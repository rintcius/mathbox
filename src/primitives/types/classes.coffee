Classes =
  axis:              require './draw/axis'
  face:              require './draw/face'
  grid:              require './draw/grid'
  line:              require './draw/line'
  point:             require './draw/point'
  strip:             require './draw/strip'
  surface:           require './draw/surface'
  ticks:             require './draw/ticks'
  vector:            require './draw/vector'

  view:              require './view/view'
  cartesian:         require './view/cartesian'
  cartesian4:        require './view/cartesian4'
  polar:             require './view/polar'
  spherical:         require './view/spherical'
  stereographic:     require './view/stereographic'
  stereographic4:    require './view/stereographic4'

  transform:         require './transform/transform3'
  transform4:        require './transform/transform4'
  vertex:            require './transform/vertex'
  layer:             require './transform/layer'

  array:             require './data/array'
  interval:          require './data/interval'
  matrix:            require './data/matrix'
  area:              require './data/area'
  voxel:             require './data/voxel'
  volume:            require './data/volume'
  scale:             require './data/scale'

  html:              require './overlay/html'
  dom:               require './overlay/dom'

  text:              require './text/text'
  format:            require './text/format'
  label:             require './text/label'

  join:              require './operator/join'
  lerp:              require './operator/lerp'
  memo:              require './operator/memo'
  resample:          require './operator/resample'
  repeat:            require './operator/repeat'
  swizzle:           require './operator/swizzle'
  spread:            require './operator/spread'
  split:             require './operator/split'
  slice:             require './operator/slice'
  transpose:         require './operator/transpose'

  group:             require './base/group'
  inherit:           require './base/inherit'
  root:              require './base/root'
  unit:              require './base/unit'

  shader:            require './shader/shader'

  camera:            require './camera/camera'

  rtt:               require './rtt/rtt'
  compose:           require './rtt/compose'

  present:           require './present/present'
  slide:             require './present/slide'
  step:              require './present/step'
  play:              require './present/play'
  track:             require './present/track'
  reveal:            require './present/reveal'
  move:              require './present/move'

module.exports = Classes