

class CA
  include Processing::Proxy
  attr_reader :rules, :scl, :generation, :cells, :height, :width
  
  def initialize(rules = nil)
    @width = $app.width
    @height = $app.height
    if rules
      @rules = rules
    else
      randomize
    end
    @scl = 1
    @cells = Array.new(width / scl, 0)
    restart
  end
  
  # Set the rules of the CA
  def setRules(r)
    @rules = r
  end
  
  # Return a random ruleset
  def randomize
    @rules = []
    8.times do
      rules << rand(0 ... 2) # non inclusive range
    end
  end
  
  # Reset to generation 0
  def restart
    cells.each do |cell|
      cell = 0
    end
    cells[cells.length/2] = 1    # We arbitrarily start with just the middle cell having a state of "1"
    @generation = 0
  end

  # The process of creating the new generation
  def generate
    # First we create an empty array for the new values
    nextgen = []
    # For every spot, determine new state by examing current state, and neighbor states
    # Ignore edges that only have one neighor
    (1 ... cells.length - 1).each do |i|
      left = cells[i-1]   # Left neighbor state
      me = cells[i]       # Current state
      right = cells[i+1]  # Right neighbor state
      nextgen << executeRules(left,me,right) # Compute next generation state based on ruleset
    end
    # Copy the array into current value
    (1 ... cells.length - 1).each do |i|
      cells[i] = nextgen[i]
    end
    #cells = (int[]) nextgen.clone
    @generation += 1
  end
  
  # This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  def render
    (0 ... cells.length).each do |i|
      if (cells[i] == 1)
        fill(255)
      else 
        fill(0)
      end
      noStroke
      rect(i*scl,generation*scl, scl,scl)
    end
  end
  
  # Implementing the Wolfram rules
  # Could be improved and made more concise, but here we can explicitly see what is going on for each case
  def executeRules (a, b, c)
    if (a == 1 && b == 1 && c == 1) 
      return rules[0] 
    elsif (a == 1 && b == 1 && c == 0) 
      return rules[1]
    elsif (a == 1 && b == 0 && c == 1) 
      return rules[2] 
    elsif (a == 1 && b == 0 && c == 0) 
      return rules[3] 
    elsif (a == 0 && b == 1 && c == 1) 
      return rules[4] 
    elsif (a == 0 && b == 1 && c == 0) 
      return rules[5] 
    elsif (a == 0 && b == 0 && c == 1) 
      return rules[6] 
    elsif (a == 0 && b == 0 && c == 0) 
      return rules[7] 
    else      
      return 0
    end
  end
  
  # The CA is done if it reaches the bottom of the screen
  def finished?
    return (@generation > @height/@scl)
  end
end
