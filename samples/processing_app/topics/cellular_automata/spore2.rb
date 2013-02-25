#
# Spore 2 
# by Mike Davis. 
# 
# A short program for alife experiments. Click in the window to restart. 
# Each cell is represented by a pixel on the display as well as an entry in
# the array 'cells'. Each cell has a run method, which performs actions
# based on the cell's surroundings.  Cells run one at a time (to adef conflicts
# like wanting to move to the same space) and in random order. 
#

attr_reader :w, :numcells, :cells, :spore1, :spore2, :spore3, :spore4, :black, :c

MAX_CELLS = 8000

# set lower for smoother animation, higher for faster simulation
RUNS_PER_LOOP = 10000

def setup 
  size(640, 360)
  frameRate(24)
  @black = color(0, 0, 0)
  reset
end

def reset 
  clearScreen
  @w = World.new
  @spore1 = color(128, 172, 255)
  @spore2 = color(64, 128, 255)
  @spore3 = color(255, 128, 172)
  @spore4 = color(255, 64, 128)
  @numcells = 0
  seed
end

def seed
  @cells = []
  # Add cells at random places
  MAX_CELLS.times do   
    cX = rand(width)
    cY = rand(height)
    r = rand
    if (r < 0.25)
      @c = spore1
    elsif (r < 0.5) 
      @c = spore2
    elsif (r < 0.75) 
      @c = spore3
    else 
      @c = spore4
    end
    if (@w.getpix(cX, cY) == black)      
      @w.setpix(cX, cY, c)
      cells << Cell.new(cX, cY)
    end
    @numcells += 1
  end
end

def draw 
  # Run cells in random order
  RUNS_PER_LOOP.times do 
    selected = min(rand(0 ... numcells), numcells - 1)
    cells[selected].run
  end
end

def clearScreen 
  background(0)
end

class Cell 
  attr_reader :x, :y, :width, :height
  def initialize(xin,  yin) 
    @x = xin
    @y = yin
    @width = $app.width
    @height = $app.height
  end
  
  # Perform action based on surroundings
  def run 
    # Fix cell coordinates
    
    @x += width if (x < 0)    
    @x -= width if (x > width - 1)    
    @y += height if (y < 0) 
    @y -= height  if (y > height - 1) 
    
    
    # Cell instructions
    myColor = @w.getpix(x, y)
    if (myColor == spore1) 
      if (@w.getpix(x - 1, y + 1) == black && @w.getpix(x + 1, y + 1) == black && @w.getpix(x, y + 1) == black) 
        move(0, 1)
      elsif (@w.getpix(x - 1, y) == spore2 && @w.getpix(x - 1, y - 1) != black) 
        move(0, -1)
      elsif (@w.getpix(x - 1, y) == spore2 && @w.getpix(x - 1, y - 1) == black) 
        move(-1, -1)
      elsif (@w.getpix(x + 1, y) == spore1 && @w.getpix(x + 1, y - 1) != black) 
        move(0, -1)
      elsif (@w.getpix(x + 1, y) == spore1 && @w.getpix(x + 1, y - 1) == black) 
        move(1, -1)
      else 
        move(rand(3) - 1, 0)
      end
    elsif (myColor == spore2) 
      if (@w.getpix(x - 1, y + 1) == black && @w.getpix(x + 1, y + 1) == black && @w.getpix(x, y + 1) == black) 
        move(0, 1)
      elsif (@w.getpix(x + 1, y) == spore1 && @w.getpix(x + 1, y - 1) != black) 
        move(0, -1)
      elsif (@w.getpix(x + 1, y) == spore1 && @w.getpix(x + 1, y - 1) == black) 
        move(1, -1)
      elsif (@w.getpix(x - 1, y) == spore2 && @w.getpix(x - 1, y - 1) != black) 
        move(0, -1)
      elsif (@w.getpix(x - 1, y) == spore2 && @w.getpix(x - 1, y - 1) == black) 
        move(-1, -1)
      else 
        move(rand(3) - 1, 0)
      end
    elsif (myColor == spore3)
      
      if (@w.getpix(x - 1, y - 1) == black && @w.getpix(x + 1, y - 1) == black && @w.getpix(x, y - 1) == black) 
        move(0, -1)
      elsif (@w.getpix(x - 1, y) == spore4 && @w.getpix(x - 1, y + 1) != black) 
        move(0, 1)
      elsif (@w.getpix(x - 1, y) == spore4 && @w.getpix(x - 1, y + 1) == black) 
        move(-1, 1)
      elsif (@w.getpix(x + 1, y) == spore3 && @w.getpix(x + 1, y + 1) != black) 
        move(0, 1)
      elsif (@w.getpix(x + 1, y) == spore3 && @w.getpix(x + 1, y + 1) == black) 
        move(1, 1)
      else 
        move(rand(3) - 1, 0)
      end
    elsif (myColor == spore4)
      
      if (@w.getpix(x - 1, y - 1) == black && @w.getpix(x + 1, y - 1) == black && @w.getpix(x, y - 1) == black) 
        move(0, -1)
      elsif (@w.getpix(x + 1, y) == spore3 && @w.getpix(x + 1, y + 1) != black) 
        move(0, 1)
      elsif (@w.getpix(x + 1, y) == spore3 && @w.getpix(x + 1, y + 1) == black) 
        move(1, 1)
      elsif (@w.getpix(x - 1, y) == spore4 && @w.getpix(x - 1, y + 1) != black) 
        move(0, 1)
      elsif (@w.getpix(x - 1, y) == spore4 && @w.getpix(x - 1, y + 1) == black) 
        move(-1, 1)
      else 
        move(rand(0 .. 3) - 1, 0)
      end
    end
  end
end

# Will move the cell (dx, dy) units if that space is empty
def move(dx, dy) 
  if (@w.getpix(x + dx, y + dy) == black) 
    @w.setpix(x + dx, y + dy, @w.getpix(x, y))
    @w.setpix(x, y, color(0))
    x += dx
    y += dy
  end
end

#  The World class simply provides two functions, get and set, which access the
#  display in the same way as getPixel and setPixel.  The only difference is that
#  the World class's get and set do screen wraparound ("toroidal coordinates").
class World
  attr_reader :width, :height
  def initialize
    @width = $app.width
    @height = $app.height
  end
  def setpix(x, y, c) 
    x+=width if(x < 0)
    x-=width if(x > width - 1)
    y+=height if(y < 0)
    y-=height if(y > height - 1)
    set(x, y, c)
  end
  
  def getpix(x, y) 
    x+=width if(x < 0)
    x-=width if(x > width - 1)
    y+=height if(y < 0)
    y-=height if(y > height - 1)
    return get(x, y)
  end
end

def mousePressed 
  reset
end

