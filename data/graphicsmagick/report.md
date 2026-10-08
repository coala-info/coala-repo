# graphicsmagick CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| graphicsmagick_compare | PASS |  |
| graphicsmagick_composite | PASS |  |
| graphicsmagick_conjure | Failed | image problem: this GraphicsMagick build has no MSL coder (conjure reports no decode delegate for the script) |
| graphicsmagick_convert | PASS |  |
| graphicsmagick_identify | PASS |  |
| graphicsmagick_mogrify | PASS |  |
| graphicsmagick_montage | PASS |  |

## graphicsmagick_convert

### Tool Description
Convert an image or sequence of images between formats and apply image operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm convert [options ...] file [ [options ...] file ...] [options ...] file

Where options include:
  -adjoin              join images into a single multi-image file
  -affine matrix       affine transform matrix
  -antialias           remove pixel-aliasing
  -append              append an image sequence
  -asc-cdl spec        apply ASC CDL transform
  -authenticate value  decrypt image with this password
  -auto-orient         orient (rotate) image so it is upright
  -average             average an image sequence
  -background color    background color
  -black-threshold value
                       pixels below the threshold become black
  -blue-primary point  chomaticity blue primary point
  -blur geometry       blur the image
  -border geometry     surround image with a border of color
  -bordercolor color   border color
  -box color           set the color of the annotation bounding box
  -channel type        extract a particular color channel from image
  -charcoal radius     simulate a charcoal drawing
  -chop geometry       remove pixels from the image interior
  -clip                apply first clipping path if the image has one
  -clippath            apply named clipping path if the image has one
  -coalesce            merge a sequence of images
  -colorize value      colorize the image with the fill color
  -colors value        preferred number of colors in the image
  -colorspace type     alternate image colorspace
  -comment string      annotate image with comment
  -compose operator    composite operator
  -compress type       image compression type
  -contrast            enhance or reduce the image contrast
  -convolve kernel     convolve image with the specified convolution kernel
  -crop geometry       preferred size and location of the cropped image
  -cycle amount        cycle the image colormap
  -debug events        display copious debugging information
  -deconstruct         break down an image sequence into constituent parts
  -define values       Coder/decoder specific options
  -delay value         display the next image after pausing
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -despeckle           reduce the speckles within an image
  -display server      get image or font from this X server
  -dispose method      Undefined, None, Background, Previous
  -dither              apply Floyd/Steinberg error diffusion to image
  -draw string         annotate the image with a graphic primitive
  -edge radius         apply a filter to detect edges in the image
  -emboss radius       emboss an image
  -encoding type       text encoding type
  -endian type         multibyte word order (LSB, MSB, or Native)
  -enhance             apply a digital filter to enhance a noisy image
  -equalize            perform histogram equalization to an image
  -extent              composite image on background color canvas image
  -fill color          color to use when filling a graphic primitive
  -filter type         use this filter when resizing an image
  -flatten             flatten a sequence of images
  -flip                flip image in the vertical direction
  -flop                flop image in the horizontal direction
  -font name           render text with this font
  -format "string"     output formatted image info for 'info:' format
  -frame geometry      surround image with an ornamental border
  -fuzz distance       colors within this distance are considered equal
  -gamma value         level of gamma correction
  -gaussian geometry   gaussian blur an image
  -geometry geometry   preferred size or location of the image
  -green-primary point chomaticity green primary point
  -gravity type        horizontal and vertical text/object placement
  -hald-clut clut      apply a Hald CLUT to the image
  -help                print program options
  -implode amount      implode image pixels about the center
  -intent type         Absolute, Perceptual, Relative, or Saturation
  -interlace type      None, Line, Plane, or Partition
  -label name          assign a label to an image
  -lat geometry        local adaptive thresholding
  -level value         adjust the level of image contrast
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height
                       Threads, Read, or Write resource limit
  -linewidth width     the line width for subsequent draw operations
  -list type           Color, Delegate, Format, Magic, Module, Resource,
                       or Type
  -log format          format of debugging information
  -loop iterations     add Netscape loop extension to your GIF animation
  -magnify             interpolate image to double size
  -map filename        transform image colors to match this set of colors
  -mask filename       set the image clip mask
  -matte               store matte channel if the image has one
  -mattecolor color    specify the color to be used with the -frame option
  -median radius       apply a median filter to the image
  -minify              interpolate the image to half size
  -modulate value      vary the brightness, saturation, and hue
  -monitor             show progress indication
  -monochrome          transform image to black and white
  -morph value         morph an image sequence
  -mosaic              create a mosaic from an image sequence
  -motion-blur radiusxsigma+angle
                       simulate motion blur
  -negate              replace every pixel with its complementary color 
  -noop                do not apply options to image
  -noise radius        add or reduce noise in an image
  -normalize           transform image to span the full range of colors
  -opaque color        change this color to the fill color
  -operator channel operator rvalue
                       apply a mathematical or bitwise operator to channel
  -ordered-dither channeltype NxN
                       ordered dither the image
  -orient orientation  set image orientation attribute
  +page                reset current page offsets to default
  -page geometry       size and location of an image canvas
  -paint radius        simulate an oil painting
  -ping                efficiently determine image attributes
  -pointsize value     font point size
  -preview type        image preview type
  -profile filename    add ICM or IPTC information profile to image
  -quality value       JPEG/MIFF/PNG compression level
  -raise value         lighten/darken image edges to create a 3-D effect
  -random-threshold channeltype LOWxHIGH
                       random threshold the image
  -recolor matrix      apply a color translation matrix to image channels
  -red-primary point   chomaticity red primary point
  -region geometry     apply options to a portion of the image
  -render              render vector graphics
  +render              disable rendering vector graphics
  -resample geometry   resample to horizontal and vertical resolution
  +repage              reset current page offsets to default
  -repage geometry     adjust current page offsets by geometry
  -resize geometry     resize the image
  -roll geometry       roll an image vertically or horizontally
  -rotate degrees      apply Paeth rotation to the image
  -sample geometry     scale image with pixel sampling
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -scale geometry      scale the image
  -scene value         image scene number
  -seed value          pseudo-random number generator seed value
  -segment values      segment an image
  -set attribute value set image attribute
  +set attribute       unset image attribute
  -shade degrees       shade the image using a distant light source
  -sharpen geometry    sharpen the image
  -shave geometry      shave pixels from the image edges
  -shear geometry      slide one edge of the image along the X or Y axis
  -size geometry       width and height of image
  -solarize threshold  negate all pixels above the threshold level
  -spread amount       displace image pixels by a random amount
  -stroke color        graphic primitive stroke color
  -strokewidth value   graphic primitive stroke width
  -strip               strip all profiles and text attributes from image
  -swirl degrees       swirl image pixels about the center
  -texture filename    name of texture to tile onto the image background
  -threshold value     threshold the image
  -thumbnail geometry  resize the image (optimized for thumbnails)
  -tile filename       tile image when filling a graphic primitive
  -transform           affine transform image
  -transparent color   make this color transparent within the image
  -treedepth value     color tree depth
  -trim                trim image edges
  -type type           image type
  -undercolor color    annotation bounding box color
  -units type          PixelsPerInch, PixelsPerCentimeter, or Undefined
  -unsharp geometry    sharpen the image
  -verbose             print detailed information about the image
  -version             print version information
  -view                FlashPix viewing transforms
  -virtual-pixel method
                       Constant, Edge, Mirror, or Tile
  -wave geometry       alter an image along a sine wave
  -white-point point   chomaticity white point
  -white-threshold value
                       pixels above the threshold become white
  -write filename      write image to this file

By default, the image format of `file' is determined by its magic
number.  To specify a particular image format, precede the filename
with an image format name and a colon (i.e. ps:image) or specify the
image type as the filename suffix (i.e. image.ps).  Specify 'file' as
'-' for standard input or output.
```

## graphicsmagick_identify

### Tool Description
Describe the format and characteristics of one or more image files.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm identify [options ...] file [ [options ...] file ... ]

Where options include:
  -debug events        display copious debugging information
  -define values       Coder/decoder specific options
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -format "string"     output formatted image characteristics
  -help                print program options
  -interlace type      None, Line, Plane, or Partition
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height or
                       Threads resource limit
  -log format          format of debugging information
  -monitor             show progress indication
  -ping                efficiently determine image attributes
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -size geometry       width and height of image
  -verbose             print detailed information about the image
  -version             print version information
  -virtual-pixel method
                       Constant, Edge, Mirror, or Tile
```

## graphicsmagick_mogrify

### Tool Description
Transform an image or a sequence of images in place.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm mogrify [options ...] file [ [options ...] file ...]

Where options include:
  -affine matrix       affine transform matrix
  -antialias           remove pixel-aliasing
  -asc-cdl spec        apply ASC CDL transform
  -authenticate value  decrypt image with this password
  -auto-orient         orient (rotate) image so it is upright
  -background color    background color
  -black-threshold value
                       pixels below the threshold become black
  -blue-primary point  chomaticity blue primary point
  -blur radius         blur the image
  -border geometry     surround image with a border of color
  -bordercolor color   border color
  -box color           set the color of the annotation bounding box
  -channel type        extract a particular color channel from image
  -charcoal radius     simulate a charcoal drawing
  -chop geometry       remove pixels from the image interior
  -colorize value      colorize the image with the fill color
  -colors value        preferred number of colors in the image
  -colorspace type     alternate image colorspace
  -comment string      annotate image with comment
  -compose operator    composite operator
  -compress type       image compression type
  -contrast            enhance or reduce the image contrast
  -convolve kernel     convolve image with the specified convolution kernel
  -create-directories  create output directories if required
  -crop geometry       preferred size and location of the cropped image
  -cycle amount        cycle the image colormap
  -debug events        display copious debugging information
  -define values       Coder/decoder specific options
  -delay value         display the next image after pausing
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -despeckle           reduce the speckles within an image
  -display server      get image or font from this X server
  -dispose method      Undefined, None, Background, Previous
  -dither              apply Floyd/Steinberg error diffusion to image
  -draw string         annotate the image with a graphic primitive
  -edge radius         apply a filter to detect edges in the image
  -emboss radius       emboss an image
  -encoding type       text encoding type
  -endian type         multibyte word order (LSB, MSB, or Native)
  -enhance             apply a digital filter to enhance a noisy image
  -equalize            perform histogram equalization to an image
  -extent              composite image on background color canvas image
  -fill color          color to use when filling a graphic primitive
  -filter type         use this filter when resizing an image
  -flip                flip image in the vertical direction
  -flop                flop image in the horizontal direction
  -font name           render text with this font
  -format type         image format type
  -frame geometry      surround image with an ornamental border
  -fuzz distance       colors within this distance are considered equal
  -gamma value         level of gamma correction
  -gaussian geometry   gaussian blur an image
  -geometry geometry   preferred size or location of the image
  -gravity type        horizontal and vertical text/object placement
  -green-primary point chomaticity green primary point
  -implode amount      implode image pixels about the center
  -interlace type      None, Line, Plane, or Partition
  -hald-clut clut      apply a Hald CLUT to the image
  -help                print program options
  -label name          assign a label to an image
  -lat geometry        local adaptive thresholding
  -level value         adjust the level of image contrast
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height or
                       Threads resource limit
  -linewidth width     the line width for subsequent draw operations
  -list type           Color, Delegate, Format, Magic, Module, Resource,
                       or Type
  -log format          format of debugging information
  -loop iterations     add Netscape loop extension to your GIF animation
  -magnify             interpolate image to double size
  -map filename        transform image colors to match this set of colors
  -mask filename       set the image clip mask
  -matte               store matte channel if the image has one
  -mattecolor color    specify the color to be used with the -frame option
  -median radius       apply a median filter to the image
  -minify              interpolate the image to half size
  -modulate value      vary the brightness, saturation, and hue
  -monitor             show progress indication
  -monochrome          transform image to black and white
  -motion-blur radiusxsigma+angle
                       simulate motion blur
  -negate              replace every pixel with its complementary color 
  -noop                do not apply options to image
  -noise radius        add or reduce noise in an image
  -normalize           transform image to span the full range of colors
  -opaque color        change this color to the fill color
  -operator channel operator rvalue
                       apply a mathematical or bitwise operator to channel
  -ordered-dither channeltype NxN
                       ordered dither the image
  -orient orientation  set image orientation attribute
  -output-directory directory
                       write output files to directory
  +page                reset current page offsets to default
  -page geometry       size and location of an image canvas
  -paint radius        simulate an oil painting
  -fill color           color for annotating or changing opaque color
  -pointsize value     font point size
  -profile filename    add ICM or IPTC information profile to image
  -preserve-timestamp  preserve original timestamps of the file
  -quality value       JPEG/MIFF/PNG compression level
  -raise value         lighten/darken image edges to create a 3-D effect
  -random-threshold channeltype LOWxHIGH
                       random threshold the image
  -recolor matrix      apply a color translation matrix to image channels
  -red-primary point   chomaticity red primary point
  -region geometry     apply options to a portion of the image
  -render              render vector graphics
  +render              disable rendering vector graphics
  -resample geometry   resample to horizontal and vertical resolution
  +repage              reset current page offsets to default
  -repage geometry     adjust current page offsets by geometry
  -resize geometry     preferred size or location of the image
  -roll geometry       roll an image vertically or horizontally
  -rotate degrees      apply Paeth rotation to the image
  -sample geometry     scale image with pixel sampling
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -scale geometry      scale the image
  -scene number        image scene number
  -seed value          pseudo-random number generator seed value
  -segment values      segment an image
  -set attribute value set image attribute
  +set attribute       unset image attribute
  -shade degrees       shade the image using a distant light source
  -sharpen radius      sharpen the image
  -shave geometry      shave pixels from the image edges
  -shear geometry      slide one edge of the image along the X or Y axis
  -size geometry       width and height of image
  -solarize threshold  negate all pixels above the threshold level
  -spread amount       displace image pixels by a random amount
  -strip               strip all profiles and text attributes from image
  -stroke color        graphic primitive stroke color
  -strokewidth value   graphic primitive stroke width
  -swirl degrees       swirl image pixels about the center
  -texture filename    name of texture to tile onto the image background
  -threshold value     threshold the image
  -thumbnail geometry  resize the image (optimized for thumbnails)
  -tile filename       tile image when filling a graphic primitive
  -transform           affine transform image
  -transparent color   make this color transparent within the image
  -treedepth value     color tree depth
  -trim                trim image edges
  -type type           image type
  -undercolor color    annotation bounding box color
  -units type          PixelsPerInch, PixelsPerCentimeter, or Undefined
  -unsharp geometry    sharpen the image
  -verbose             print detailed information about the image
  -version             print version information
  -view                FlashPix viewing transforms
  -virtual-pixel method
                       Constant, Edge, Mirror, or Tile
  -wave geometry       alter an image along a sine wave
  -white-point point   chomaticity white point
  -white-threshold value
                       pixels above the threshold become white

By default, the image format of `file' is determined by its magic
number.  To specify a particular image format, precede the filename
with an image format name and a colon (i.e. ps:image) or specify the
image type as the filename suffix (i.e. image.ps).  Specify 'file' as
'-' for standard input or output.
```

## graphicsmagick_montage

### Tool Description
Create a composite image (a grid of tiles) from separate images.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm montage [options ...] file [ [options ...] file ...]

Where options include:
  -adjoin              join images into a single multi-image file
  -affine matrix       affine transform matrix
  -authenticate value  decrypt image with this password
  -background color    background color
  -blue-primary point  chomaticity blue primary point
  -blur factor         apply a filter to blur the image
  -bordercolor color   border color
  -borderwidth geometry
                       border width
  -colors value        preferred number of colors in the image
  -colorspace type     alternate image colorsapce
  -comment string      annotate image with comment
  -compose operator    composite operator
  -compress type       image compression type
  -crop geometry       preferred size and location of the cropped image
  -debug events        display copious debugging information
  -define values       Coder/decoder specific options
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -display server      query font from this X server
  -dispose method      Undefined, None, Background, Previous
  -dither              apply Floyd/Steinberg error diffusion to image
  -draw string         annotate the image with a graphic primitive
  -encoding type       text encoding type
  -endian type         multibyte word order (LSB, MSB, or Native)
  -fill color          color to use when filling a graphic primitive
  -filter type         use this filter when resizing an image
  -flip                flip image in the vertical direction
  -flop                flop image in the horizontal direction
  -font name           font to use when annotating with text
  -format string       output formatted image characteristics
  -frame geometry      surround image with an ornamental border
  -gamma value         level of gamma correction
  -geometry geometry   preferred tile and border sizes
  -gravity direction   which direction to gravitate towards
  -green-primary point chomaticity green primary point
  -help                print program options
  -interlace type      None, Line, Plane, or Partition
  -label name          assign a label to an image
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height or
                       Threads resource limit
  -log format          format of debugging information
  -matte               store matte channel if the image has one
  -mattecolor color    color to be used with the -frame option
  -mode type           Frame, Unframe, or Concatenate
  -monitor             show progress indication
  -monochrome          transform image to black and white
  -noop                do not apply options to image
  +page                reset current page offsets to default
  -page geometry       size and location of an image canvas
  -pointsize value     font point size
  -quality value       JPEG/MIFF/PNG compression level
  -red-primary point   chomaticity red primary point
  +repage              reset current page offsets to default
  -repage geometry     adjust current page offsets by geometry
  -resize geometry     resize the image
  -rotate degrees      apply Paeth rotation to the image
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -scenes range        image scene range
  -set attribute value set image attribute
  +set attribute       unset image attribute
  -shadow              add a shadow beneath a tile to simulate depth
  -sharpen geometry    sharpen the image
  -size geometry       width and height of image
  -strip               strip all profiles and text attributes from image
  -stroke color        color to use when stroking a graphic primitive
  -strokewidth value   stroke (line) width
  -texture filename    name of texture to tile onto the image background
  -thumbnail geometry  resize the image (optimized for thumbnails)
  -tile geometry       number of tiles per row and column
  -title string        thumbnail title
  -transform           affine transform image
  -transparent color   make this color transparent within the image
  -treedepth value     color tree depth
  -trim                trim image edges
  -type type           image type
  -verbose             print detailed information about the image
  -version             print version information
  -virtual-pixel method
                       Constant, Edge, Mirror, or Tile
  -white-point point   chomaticity white point

In addition to those listed above, you can specify these standard X
resources as command line options:  -background, -bordercolor,
-borderwidth, -font, -mattecolor, or -title

By default, the image format of `file' is determined by its magic
number.  To specify a particular image format, precede the filename
with an image format name and a colon (i.e. ps:image) or specify the
image type as the filename suffix (i.e. image.ps).  Specify 'file' as
'-' for standard input or output.
```

## graphicsmagick_composite

### Tool Description
Overlay one image over another.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm composite [options ...] image [options ...] composite
  [ [options ...] mask ] [options ...] composite

Where options include:
  -affine matrix       affine transform matrix
  -authenticate value  decrypt image with this password
  -blue-primary point  chomaticity blue primary point
  -colors value        preferred number of colors in the image
  -colorspace type     alternate image colorspace
  -comment string      annotate image with comment
  -compose operator    composite operator
  -compress type       image compression type
  -debug events        display copious debugging information
  -define values       Coder/decoder specific options
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -displace geometry   shift image pixels defined by a displacement map
  -display server      get image or font from this X server
  -dispose method      Undefined, None, Background, Previous
  -dissolve value      dissolve the two images a given percent
  -dither              apply Floyd/Steinberg error diffusion to image
  -encoding type       text encoding type
  -endian type         multibyte word order (LSB, MSB, or Native)
  -filter type         use this filter when resizing an image
  -font name           render text with this font
  -geometry geometry   location of the composite image
  -gravity type        which direction to gravitate towards
  -green-primary point chomaticity green primary point
  -help                print program options
  -interlace type      None, Line, Plane, or Partition
  -label name          ssign a label to an image
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height
                       Threads, Read, or Write resource limit
  -log format          format of debugging information
  -matte               store matte channel if the image has one
  -monitor             show progress indication
  -monochrome          transform image to black and white
  -negate              replace every pixel with its complementary color 
  +page                reset current page offsets to default
  -page geometry       size and location of an image canvas
  -profile filename    add ICM or IPTC information profile to image
  -quality value       JPEG/MIFF/PNG compression level
  -recolor matrix      apply a color translation matrix to image channels
  -red-primary point   chomaticity red primary point
  -rotate degrees      apply Paeth rotation to the image
  +repage              reset current page offsets to default
  -repage geometry     adjust current page offsets by geometry
  -resize geometry     resize the image
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -scene value         image scene number
  -set attribute value set image attribute
  +set attribute       unset image attribute
  -sharpen geometry    sharpen the image
  -size geometry       width and height of image
  -stegano offset      hide watermark within an image
  -stereo              combine two image to create a stereo anaglyph
  -strip               strip all profiles and text attributes from image
  -thumbnail geometry  resize the image (optimized for thumbnails)
  -tile                repeat composite operation across image
  -transform           affine transform image
  -treedepth value     color tree depth
  -type type           image type
  -units type          PixelsPerInch, PixelsPerCentimeter, or Undefined
  -unsharp geometry    sharpen the image
  -verbose             print detailed information about the image
  -version             print version information
  -virtual-pixel method
                       Constant, Edge, Mirror, or Tile
  -watermark geometry  percent brightness and saturation of a watermark
  -white-point point   chomaticity white point
  -write filename      write image to this file
```

## graphicsmagick_compare

### Tool Description
Compare two images and report the difference.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm compare [options ...] reference [options ...] compare [options ...]

Where options include:
  -authenticate value  decrypt image with this password
  -auto-orient         orient (rotate) images so they are upright
  -colorspace type     alternate image colorspace
  -compress type       image compression type
  -debug events        display copious debugging information
  -define values       coder/decoder specific options
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -display server      get image or font from this X server
  -endian type         multibyte word order (LSB, MSB, or Native)
  -file filename       write difference image to this file
  -help                print program options
  -highlight-color color
                       color to use when annotating difference pixels
  -highlight-style style
                       pixel highlight style (assign, threshold, tint, xor)
  -interlace type      None, Line, Plane, or Partition
  -limit type value    Disk, File, Map, Memory, Pixels, Width, Height
                       Threads, Read, or Write resource limit
  -log format          format of debugging information
  -matte               store matte channel if the image has one
  -maximum-error       maximum total difference before returning error
  -metric              comparison metric (MAE, MSE, PAE, PSNR, RMSE)
  -monitor             show progress indication
  -sampling-factor HxV[,...]
                       horizontal and vertical sampling factors
  -size geometry       width and height of image
  -type type           image type
  -verbose             print detailed information about the image
  -version             print version information
```

## graphicsmagick_conjure

### Tool Description
Execute a Magick Scripting Language (MSL) XML script.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphicsmagick:1.3.46
- **Homepage**: http://www.graphicsmagick.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/graphicsmagick/overview
- **Validation**: PASS

### Original Help Text
```text
GraphicsMagick 1.3.46 2025-10-29 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2025 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
Usage: gm conjure [options ...] file [ [options ...] file ...]

Where options include:
  -debug events        display copious debugging information
  -help                print program options
  -log format          format of debugging information
  -verbose             print detailed information about the image
  -version             print version information

In addition, define any key value pairs required by your script.  For
example,

    conjure -size 100x100 -color blue -foo bar script.msl
```
