# This example demonstrates how to rotate a number of meshes
# so that each points towards a common & user controlled focal point.
#
# Requires toxiclibs-0020 or newer
#
# (c) 2012 Karsten Schmidt / LGPL2 licensed
#
load_libraries 'toxiclibscore', 'toxiclibs_p5', 'colorutils'

include_package 'toxi.geom'
include_package 'toxi.geom.mesh'
include_package 'toxi.processing'

# container for mesh positions

attr_reader :gfx, :positions

def setup
  size(640,480,P3D)
  @gfx = ToxiclibsSupport.new(self)
  @positions = []
  # compute mesh positions on circle in XZ plane
  (Circle.new(200).toPolygon2D(8)).each do |p|
    positions.push(p.to3DXZ())
  end
end

def draw
  background(51)
  lights()
  no_stroke()
  translate(width/2,height/2,0)
  rotate_x(-PI/6)
  # create manual focal point in XY plane
  focus = Vec3D.new((mouse_x - width/2), (mouse_y - height/2), 0)
  # create mesh prototype to draw at all generated positions
  # the mesh is a simple box placed at the world origin
  m = AABB.new(25).to_mesh()
  # draw focus
  gfx.box(AABB.new(focus, 5))
  positions.each do |p|
    # align the positive z-axis of mesh to point at focus
    # mesh needs to be located at world origin for it to work correctly
    # only once rotated, move it to actual position
    gfx.mesh(m.copy().pointTowards(focus.sub(p), Vec3D::Z_AXIS).translate(p))
  end
  # draw connections from mesh centers to focal point
  stroke(0,255,255)
  positions.each do |p|
    gfx.line(p, focus)
  end
end

