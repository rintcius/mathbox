Base           = require './base'
SpriteGeometry = require('../geometry').SpriteGeometry

class Point extends Base
  constructor: (renderer, shaders, options) ->
    super renderer, shaders, options

    {uniforms, material, position, color, mask, map, combine, linear, shape, fill, stpq} = options

    uniforms ?= {}
    shape     = +shape ? 0
    fill     ?= true

    hasStyle = uniforms.styleColor?

    shapes   = ['circle', 'square', 'diamond', 'triangle']
    passes   = ['circle', 'generic', 'generic', 'generic']
    pass     = passes[shape] ? passes[0]
    _shape   = shapes[shape] ? shapes[0]
    alpha    = if fill then pass else "#{pass}.hollow"

    @geometry = new SpriteGeometry
      items:  options.items
      width:  options.width
      height: options.height
      depth:  options.depth

    @_adopt uniforms
    @_adopt @geometry.uniforms

    # Shared vertex shader
    factory = shaders.material()
    v = factory.vertex

    v.pipe @_vertexColor color, mask

    v.require @_vertexPosition position, material, map, 2, stpq
    v.pipe 'point.position',        @uniforms
    v.pipe 'project.position',      @uniforms

    # Shared fragment shader
    factory.fragment = f =
      @_fragmentColor hasStyle, material, color, mask, map, 2, stpq, combine, linear

    # Split fragment into edge and fill pass for better z layering
    edgeFactory = shaders.material()
    edgeFactory.vertex.pipe v
    f = edgeFactory.fragment.pipe factory.fragment
    f.require "point.mask.#{_shape}",  @uniforms
    f.require "point.alpha.#{alpha}",  @uniforms
    f.pipe 'point.edge',               @uniforms

    fillFactory = shaders.material()
    fillFactory.vertex.pipe v
    f = fillFactory.fragment.pipe factory.fragment
    f.require "point.mask.#{_shape}",  @uniforms
    f.require "point.alpha.#{alpha}",  @uniforms
    f.pipe 'point.fill',               @uniforms

    @fillMaterial = @_material fillFactory.link
      side: THREE.DoubleSide

    @edgeMaterial = @_material edgeFactory.link
      side: THREE.DoubleSide

    @fillObject = new THREE.Mesh @geometry, @fillMaterial
    @edgeObject = new THREE.Mesh @geometry, @edgeMaterial

    @_raw @fillObject
    @_raw @edgeObject

    @renders = [@fillObject, @edgeObject]

  show: (transparent, blending, order, depth) ->
    @_show @edgeObject, true,        blending, order, depth
    @_show @fillObject, transparent, blending, order, depth

  dispose: () ->
    @geometry.dispose()
    @edgeMaterial.dispose()
    @fillMaterial.dispose()
    @renders = @edgeObject = @fillObject = @geometry = @edgeMaterial = @fillMaterial = null
    super

module.exports = Point
