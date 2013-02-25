#
# Wolfram Cellular Automata
# by Daniel Shiffman.  
# 
# Simple demonstration of a Wolfram 1-dimensional cellular automata
# When the system reaches bottom of the window, it restarts with a new ruleset
# Mouse click restarts as well. 
#
load_library 'ca'
 
attr_reader :ca   # An instance object to describe the Wolfram basic Cellular Automata

def setup
  size(640, 360, P2D)
  frameRate(30)
  background(0)
  ruleset = [0,1,0,1,1,0,1,0]    # An initial rule system
  @ca = CA.new(ruleset)          # Initialize CA
end

def draw
  ca.render    # Draw the CA
  ca.generate  # Generate the next level
  
  if ca.finished?  # If we're done, clear the screen, pick a new ruleset and restart
    background(0)
    ca.randomize
    ca.restart
  end
end

def mouse_pressed
  background(0)
  ca.randomize
  ca.restart
end



