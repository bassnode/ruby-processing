#
# Non-orthogonal Reflection 
# by Ira Greenberg. 
# 
# Based on the equation (R = 2N(N*L)-L) where R is the 
# reflection vector, N is the normal, and L is the incident
# vector.
#

attr_reader :base_x1, :base_y1, :base_x2, :base_y2, :base_length
attr_reader :x_coords, :y_coords, :ellipse_x, :ellipse_y, :ellipse_radius
attr_reader :direction_x, :direction_y, :ellipse_speed, :velocity_x, :velocity_y 

def setup
  size(640, 360)
  @ellipse_radius = 6
  @ellipse_y = 6
  @ellipse_x = 6
  @ellipse_speed = 3.5
  fill(128)
  @base_x1 = 0
  @base_y1 = height-150
  @base_x2 = width
  @base_y2 = height
  
  # start ellipse at middle top of screen
  @ellipse_x = width/2
  
  # calculate initial random direction
  @direction_x = rand(0.1 .. 0.99)
  @direction_y = rand(0.1 .. 0.99)
  
  # normalize direction vector
  direction_vect_length = sqrt(direction_x * direction_x + direction_y * direction_y)
  @direction_x /= direction_vect_length
  @direction_y /= direction_vect_length
end

def draw
  # draw background
  fill(0, 12)
  no_stroke
  rect(0, 0, width, height)
  
  # calculate length of base top
  @base_length = dist(base_x1, base_y1, base_x2, base_y2)
  @x_coords = []
  @y_coords = []
  # fill base top coordinate array
  (0 ... base_length.ceil).each do |i|
    @x_coords << base_x1 + ((base_x2 - base_x1) / base_length) * i
    @y_coords << base_y1 + ((base_y2 - base_y1) / base_length) * i
  end
  
  # draw base
  fill(200)
  quad(base_x1, base_y1, base_x2, base_y2, base_x2, height, 0, height)
  
  # calculate base top normal
  base_delta_x = (base_x2-base_x1) / base_length
  base_delta_y = (base_y2-base_y1) / base_length
  normal_x = -base_delta_y
  normal_y = base_delta_x
  
  # draw ellipse
  no_stroke
  fill(255)
  ellipse(ellipse_x, ellipse_y, ellipse_radius*2, ellipse_radius*2)
  
  # calculate ellipse velocity
  @velocity_x = direction_x * ellipse_speed
  @velocity_y = direction_y * ellipse_speed
  
  # move elipse
  @ellipse_x += velocity_x
  @ellipse_y += velocity_y
  
  # normalized incidence vector
  incidence_vector_x = -direction_x
  incidence_vector_y = - direction_y
  
  # detect and handle collision
  (0 ... x_coords.length).each do |i|
    # check distance between ellipse and base top coordinates
    if (dist(ellipse_x, ellipse_y, x_coords[i], y_coords[i]) < ellipse_radius)
      
      # calculate dot product of incident vector and base top normal 
      dot = incidence_vector_x * normal_x + incidence_vector_y * normal_y
      
      # calculate reflection vector
      reflection_vector_x = 2 * normal_x * dot - incidence_vector_x
      reflection_vector_y = 2 * normal_y * dot - incidence_vector_y
      
      # assign reflection vector to direction vector
      @direction_x = reflection_vector_x
      @direction_y = reflection_vector_y
      
      # draw base top normal at collision point
      stroke(255, 128, 0)
      line(ellipse_x, ellipse_y, ellipse_x - normal_x * 100, ellipse_y - normal_y * 100)
    end
  end
  
  # detect boundary collision
  # right
  if (ellipse_x > width-ellipse_radius)
    @ellipse_x = width-ellipse_radius
    @direction_x *= -1
  end
  # left 
  if (ellipse_x < ellipse_radius)
    @ellipse_x = ellipse_radius
    @direction_x *= -1
  end
  # top
  if (ellipse_y < ellipse_radius)
    @ellipse_y = ellipse_radius
    @direction_y *= -1
    # randomize base top
    @base_y1 = rand(height - 100 .. height)
    @base_y2 = rand(height - 100 .. height)
  end
end


