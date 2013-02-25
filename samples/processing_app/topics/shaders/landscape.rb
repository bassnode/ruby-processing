##
# Landscape
# Simple raymarching shader with camera, originally by Paulo Falcão
# Ported from the webGL version in GLSL Sandbox:
# http:#glsl.heroku.com/e#3213.0
#
##
 
attr_reader :landscape, :pg

def setup
  size(640, 360, P2D)
  
  # This effect can be too demanding on older GPUs, so we can 
  # render it on a smaller res offscreen surface uncomment below
  # @pg = create_graphics(320, 180, P2D)
  @pg = create_graphics(640, 360, P2D)
  pg.no_stroke  
  @landscape = load_shader("landscape.glsl")
  landscape.set("resolution", width.to_f, height.to_f)
end

def draw
  landscape.set("time", millis / 1000.0)
  landscape.set("mouse", mouse_x.to_f, height - mouse_y.to_f)
  
  # This kind of raymarching effects are entirely implemented in the
  # fragment shader, they only need a quad covering the entire view 
  # area so every pixel is pushed through the shader.  
  pg.begin_draw
  pg.shader(landscape)  
  pg.rect(0, 0, width, height)
  pg.end_draw

  # Scaling up offscreen surface to cover entire screen (if reduced).
  image(pg, 0, 0, width, height)  
end
