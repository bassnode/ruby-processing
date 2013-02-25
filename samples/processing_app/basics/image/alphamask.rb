# Loads a "mask" for an image to specify the transparency 
# in different parts of the image. The two images are blended
# together using the mask() method of PImage. 


def setup
  size 200, 200
  @image = load_image "test.jpg"
  @image_mask = load_image "mask.jpg"
  @image.mask @image_mask
end

def draw
  background (mouse_x + mouse_y) / 1.5
  image @image, 50, 50
  image @image, mouse_x-50, mouse_y-50
end
