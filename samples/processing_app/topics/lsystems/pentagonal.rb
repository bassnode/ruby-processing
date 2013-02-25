############################
# pentagonal.rb here I roll one of my own
###########################
load_library 'grammar'

class Pentagonal
  include Processing::Proxy
  import 'grammar'
  DELTA = (Math::PI/180) * 72.0    # convert degrees to radians
  attr_accessor :draw_length
  attr_reader :axiom, :grammar, :theta, :production, :xpos, :ypos
  def initialize xpos, ypos
    @axiom = "F-F-F-F-F"
    @grammar = Grammar.new( axiom,
    {"F" => "F+F+F-F-F-F+F+F"}
    )
    @draw_length = 220
    @theta = 0.0
    @xpos = xpos
    @ypos = ypos
  end
  
  ##############################
  # create grammar from axiom and
  # rules (adjust scale)
  ##############################

  def create_grammar(gen)
    @draw_length *= 0.37**gen
    @production = grammar.generate gen
  end 
  
  def make_shape
    no_fill
    shape = create_shape
    shape.begin_shape
    shape.stroke 200
    shape.stroke_weight 3
    shape.vertex(xpos, ypos)
    production.each do |element|
      case element
      when 'F'                     # you could use affine transforms here, I prefer to do the Math
        shape.vertex((@xpos -= draw_length * cos(theta)), (@ypos += draw_length * sin(theta)))   
      when '+'
        @theta += DELTA        
      when '-'
        @theta -= DELTA        
      else puts "Grammar not recognized"
      end
    end
  shape.end_shape
  return shape
  end
end

##
# A Pentagonal Fractal created using a
# Lindenmayer System in ruby-processing by Martin Prout
###

attr_reader :pentagonal, :pentive, :gen

def setup
  size 800, 800, P2D
  @pentagonal = Pentagonal.new width * 0.65, height * 0.75
  @gen = 2
  build_shape
end

def draw
  background 0  
  shape(pentive, 0, 0)
end

def build_shape
  pentagonal.draw_length = 220
  pentagonal.create_grammar gen
  @pentive = pentagonal.make_shape 
end


def key_pressed
  case key
  when 'i', 'I'  # increase generations
    @gen += gen unless gen > 3
    build_shape
  when 'd', 'D'  # increase generations
    @gen -= gen unless gen < 2
    build_shape
  else
    @gen = 2     # reset to original
    build_shape
  end
end
