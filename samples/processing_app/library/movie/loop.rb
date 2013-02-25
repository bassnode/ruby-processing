# Loop. 
# 
# Shows how to load and play a QuickTime movie file.  
#
#

load_library 'video'

include_package 'processing.video'

attr_reader :movie

def setup
  size(640, 360)
  background(0)
  # Load and play the video in a loop
  @movie = Movie.new(self, "transit.mov")
  movie.loop
end

def movieEvent(m)
  m.read
end

def draw
  if (movie.available) # needed with ruby-processing on linux
    movie.read 
  end
  image(movie, 0, 0, width, height)
end
