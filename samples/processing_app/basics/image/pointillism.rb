
# Pointillism
# by Daniel Shiffman. 
# 
# Mouse horizontal location controls size of dots. 
# Creates a simple pointillist effect using ellipses colored
# according to pixels in an image. 


def setup
  size 200, 200
  @a = load_image "eames.jpg"  
  no_stroke
  background 255
  smooth
end

def draw
  pointillize = map mouse_x, 0, width, 2, 18
  x, y = rand(@a.width), rand(@a.height)
  pixel = @a.get(x, y)
  fill pixel, 126
  ellipse x, y, pointillize, pointillize
end
