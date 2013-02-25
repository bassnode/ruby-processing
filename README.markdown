# Work In Progress #
Updated fork to remove binary crud 25 February 2013 (and restructured samples folder, in line with vanilla processing). Built in library examples have been updated and extended, now includes a new 100% ruby ArcBall library.
## Updating ruby-processing to JRuby-1.7.3 ##
This is is emminently sensible and readily achievable, note default is to run with ruby-1.9 support. To get better support for dynamic language use java-1.7+.
## Updating ruby-processing for processing-2.0 ##
This is highly !desirable but comes at a cost in terms of compatability. This fork is based on the released version of processing-2.0b8. Likely problems are library incompatability with existing libraries, at least at first. The control_panel is now working (albeit not quite as in original ruby-processing) all sketches have been made classeless (ie they now implicitly rather than explicitly extend Processing::App, all seem to run fine, including latest contributed mandelbrot set).
!Highly desirable includes improved opengl graphics access to shaders FBO etc. Examples featuring shaders include monjori and landscape, fbo examples include a menger sponge (arcball library) and a large rotating cubes (performance). 
