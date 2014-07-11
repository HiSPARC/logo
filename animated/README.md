Animated logo
=============

The HiSPARC_animated.tex contains parameterized version of the header
logo. Using a for loop one figure is created for every step of the
shower. These are output to different pages in the pdf using the preview
package.


Convert to GIF
--------------

Compiling this tex files creates a multi-page pdf. Where each page is
one frame of the animation. Here is a guide how to produce an animated
gif from this multi-page pdf, note that this works on a Mac and uses
non-free software.

Software: Graphic Converter, Quicktime Player 7 Pro.

- Open the output pdf in Graphic Converter at 96 dpi (192 dpi for retina)
- Save As
    - Format: png
    - Check: Save all pages of multipage files
- In Quicktime use 'Open Image Sequence' to create a movie
- Save this as a self-contained movie
- Open the movie in Graphic Converter
- Choose Effect -> Channels/Frames -> Convert Movie to Animation
- Open the GIF Animation Window
- Check Loop and set the duration for all frames to 0.05
- Set duration of last frame to 0.2
- Save this as a gif


![Animated logo](https://raw.github.com/HiSPARC/logo/animated/animated/HiSPARC_animated.gif)
