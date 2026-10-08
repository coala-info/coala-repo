cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - convert
label: graphicsmagick_convert
doc: "Convert an image or sequence of images between formats and apply image operations (resize, crop, rotate, colour changes, ...).\n\nTool homepage: http://www.graphicsmagick.org/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input image file(s). Options given as inputs apply to the images read.
    inputBinding:
      position: 10
  - id: output_file
    type: string
    doc: Output image file name; the format follows the suffix (or a format prefix such as png:out).
    inputBinding:
      position: 30
  - id: adjoin
    type:
      - 'null'
      - boolean
    doc: "join images into a single multi-image file"
    inputBinding:
      position: 20
      prefix: "-adjoin"
  - id: affine
    type:
      - 'null'
      - string
    doc: "affine transform matrix"
    inputBinding:
      position: 20
      prefix: "-affine"
  - id: antialias
    type:
      - 'null'
      - boolean
    doc: "remove pixel-aliasing"
    inputBinding:
      position: 20
      prefix: "-antialias"
  - id: append
    type:
      - 'null'
      - boolean
    doc: "append an image sequence"
    inputBinding:
      position: 20
      prefix: "-append"
  - id: asc_cdl
    type:
      - 'null'
      - string
    doc: "apply ASC CDL transform"
    inputBinding:
      position: 20
      prefix: "-asc-cdl"
  - id: authenticate
    type:
      - 'null'
      - string
    doc: "decrypt image with this password"
    inputBinding:
      position: 5
      prefix: "-authenticate"
  - id: auto_orient
    type:
      - 'null'
      - boolean
    doc: "orient (rotate) image so it is upright"
    inputBinding:
      position: 20
      prefix: "-auto-orient"
  - id: average
    type:
      - 'null'
      - boolean
    doc: "average an image sequence"
    inputBinding:
      position: 20
      prefix: "-average"
  - id: background
    type:
      - 'null'
      - string
    doc: "background color"
    inputBinding:
      position: 20
      prefix: "-background"
  - id: black_threshold
    type:
      - 'null'
      - string
    doc: "pixels below the threshold become black"
    inputBinding:
      position: 20
      prefix: "-black-threshold"
  - id: blue_primary
    type:
      - 'null'
      - string
    doc: "chomaticity blue primary point"
    inputBinding:
      position: 20
      prefix: "-blue-primary"
  - id: blur
    type:
      - 'null'
      - string
    doc: "blur the image"
    inputBinding:
      position: 20
      prefix: "-blur"
  - id: border
    type:
      - 'null'
      - string
    doc: "surround image with a border of color"
    inputBinding:
      position: 20
      prefix: "-border"
  - id: bordercolor
    type:
      - 'null'
      - string
    doc: "border color"
    inputBinding:
      position: 20
      prefix: "-bordercolor"
  - id: box
    type:
      - 'null'
      - string
    doc: "set the color of the annotation bounding box"
    inputBinding:
      position: 20
      prefix: "-box"
  - id: channel
    type:
      - 'null'
      - string
    doc: "extract a particular color channel from image"
    inputBinding:
      position: 20
      prefix: "-channel"
  - id: charcoal
    type:
      - 'null'
      - string
    doc: "simulate a charcoal drawing"
    inputBinding:
      position: 20
      prefix: "-charcoal"
  - id: chop
    type:
      - 'null'
      - string
    doc: "remove pixels from the image interior"
    inputBinding:
      position: 20
      prefix: "-chop"
  - id: clip
    type:
      - 'null'
      - boolean
    doc: "apply first clipping path if the image has one"
    inputBinding:
      position: 20
      prefix: "-clip"
  - id: clippath
    type:
      - 'null'
      - boolean
    doc: "apply named clipping path if the image has one"
    inputBinding:
      position: 20
      prefix: "-clippath"
  - id: coalesce
    type:
      - 'null'
      - boolean
    doc: "merge a sequence of images"
    inputBinding:
      position: 20
      prefix: "-coalesce"
  - id: colorize
    type:
      - 'null'
      - string
    doc: "colorize the image with the fill color"
    inputBinding:
      position: 20
      prefix: "-colorize"
  - id: colors
    type:
      - 'null'
      - string
    doc: "preferred number of colors in the image"
    inputBinding:
      position: 20
      prefix: "-colors"
  - id: colorspace
    type:
      - 'null'
      - string
    doc: "alternate image colorspace"
    inputBinding:
      position: 20
      prefix: "-colorspace"
  - id: comment
    type:
      - 'null'
      - string
    doc: "annotate image with comment"
    inputBinding:
      position: 20
      prefix: "-comment"
  - id: compose
    type:
      - 'null'
      - string
    doc: "composite operator"
    inputBinding:
      position: 20
      prefix: "-compose"
  - id: compress
    type:
      - 'null'
      - string
    doc: "image compression type"
    inputBinding:
      position: 20
      prefix: "-compress"
  - id: contrast
    type:
      - 'null'
      - boolean
    doc: "enhance or reduce the image contrast"
    inputBinding:
      position: 20
      prefix: "-contrast"
  - id: convolve
    type:
      - 'null'
      - string
    doc: "convolve image with the specified convolution kernel"
    inputBinding:
      position: 20
      prefix: "-convolve"
  - id: crop
    type:
      - 'null'
      - string
    doc: "preferred size and location of the cropped image"
    inputBinding:
      position: 20
      prefix: "-crop"
  - id: cycle
    type:
      - 'null'
      - string
    doc: "cycle the image colormap"
    inputBinding:
      position: 20
      prefix: "-cycle"
  - id: debug
    type:
      - 'null'
      - string
    doc: "display copious debugging information"
    inputBinding:
      position: 20
      prefix: "-debug"
  - id: deconstruct
    type:
      - 'null'
      - boolean
    doc: "break down an image sequence into constituent parts"
    inputBinding:
      position: 20
      prefix: "-deconstruct"
  - id: define
    type:
      - 'null'
      - string
    doc: "Coder/decoder specific options"
    inputBinding:
      position: 20
      prefix: "-define"
  - id: delay
    type:
      - 'null'
      - string
    doc: "display the next image after pausing"
    inputBinding:
      position: 20
      prefix: "-delay"
  - id: density
    type:
      - 'null'
      - string
    doc: "horizontal and vertical density of the image"
    inputBinding:
      position: 5
      prefix: "-density"
  - id: depth
    type:
      - 'null'
      - string
    doc: "image depth"
    inputBinding:
      position: 5
      prefix: "-depth"
  - id: despeckle
    type:
      - 'null'
      - boolean
    doc: "reduce the speckles within an image"
    inputBinding:
      position: 20
      prefix: "-despeckle"
  - id: dispose
    type:
      - 'null'
      - string
    doc: "Undefined, None, Background, Previous"
    inputBinding:
      position: 20
      prefix: "-dispose"
  - id: dither
    type:
      - 'null'
      - boolean
    doc: "apply Floyd/Steinberg error diffusion to image"
    inputBinding:
      position: 20
      prefix: "-dither"
  - id: draw
    type:
      - 'null'
      - string
    doc: "annotate the image with a graphic primitive"
    inputBinding:
      position: 20
      prefix: "-draw"
  - id: edge
    type:
      - 'null'
      - string
    doc: "apply a filter to detect edges in the image"
    inputBinding:
      position: 20
      prefix: "-edge"
  - id: emboss
    type:
      - 'null'
      - string
    doc: "emboss an image"
    inputBinding:
      position: 20
      prefix: "-emboss"
  - id: encoding
    type:
      - 'null'
      - string
    doc: "text encoding type"
    inputBinding:
      position: 20
      prefix: "-encoding"
  - id: endian
    type:
      - 'null'
      - string
    doc: "multibyte word order (LSB, MSB, or Native)"
    inputBinding:
      position: 5
      prefix: "-endian"
  - id: enhance
    type:
      - 'null'
      - boolean
    doc: "apply a digital filter to enhance a noisy image"
    inputBinding:
      position: 20
      prefix: "-enhance"
  - id: equalize
    type:
      - 'null'
      - boolean
    doc: "perform histogram equalization to an image"
    inputBinding:
      position: 20
      prefix: "-equalize"
  - id: extent
    type:
      - 'null'
      - boolean
    doc: "composite image on background color canvas image"
    inputBinding:
      position: 20
      prefix: "-extent"
  - id: fill
    type:
      - 'null'
      - string
    doc: "color to use when filling a graphic primitive"
    inputBinding:
      position: 20
      prefix: "-fill"
  - id: filter
    type:
      - 'null'
      - string
    doc: "use this filter when resizing an image"
    inputBinding:
      position: 20
      prefix: "-filter"
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: "flatten a sequence of images"
    inputBinding:
      position: 20
      prefix: "-flatten"
  - id: flip
    type:
      - 'null'
      - boolean
    doc: "flip image in the vertical direction"
    inputBinding:
      position: 20
      prefix: "-flip"
  - id: flop
    type:
      - 'null'
      - boolean
    doc: "flop image in the horizontal direction"
    inputBinding:
      position: 20
      prefix: "-flop"
  - id: font
    type:
      - 'null'
      - string
    doc: "render text with this font"
    inputBinding:
      position: 20
      prefix: "-font"
  - id: format
    type:
      - 'null'
      - string
    doc: "output formatted image info for 'info:' format"
    inputBinding:
      position: 20
      prefix: "-format"
  - id: frame
    type:
      - 'null'
      - string
    doc: "surround image with an ornamental border"
    inputBinding:
      position: 20
      prefix: "-frame"
  - id: fuzz
    type:
      - 'null'
      - string
    doc: "colors within this distance are considered equal"
    inputBinding:
      position: 20
      prefix: "-fuzz"
  - id: gamma
    type:
      - 'null'
      - string
    doc: "level of gamma correction"
    inputBinding:
      position: 20
      prefix: "-gamma"
  - id: gaussian
    type:
      - 'null'
      - string
    doc: "gaussian blur an image"
    inputBinding:
      position: 20
      prefix: "-gaussian"
  - id: geometry
    type:
      - 'null'
      - string
    doc: "preferred size or location of the image"
    inputBinding:
      position: 20
      prefix: "-geometry"
  - id: green_primary
    type:
      - 'null'
      - string
    doc: "chomaticity green primary point"
    inputBinding:
      position: 20
      prefix: "-green-primary"
  - id: gravity
    type:
      - 'null'
      - string
    doc: "horizontal and vertical text/object placement"
    inputBinding:
      position: 20
      prefix: "-gravity"
  - id: hald_clut
    type:
      - 'null'
      - File
    doc: "apply a Hald CLUT to the image"
    inputBinding:
      position: 20
      prefix: "-hald-clut"
  - id: implode
    type:
      - 'null'
      - string
    doc: "implode image pixels about the center"
    inputBinding:
      position: 20
      prefix: "-implode"
  - id: intent
    type:
      - 'null'
      - string
    doc: "Absolute, Perceptual, Relative, or Saturation"
    inputBinding:
      position: 20
      prefix: "-intent"
  - id: interlace
    type:
      - 'null'
      - string
    doc: "None, Line, Plane, or Partition"
    inputBinding:
      position: 20
      prefix: "-interlace"
  - id: label
    type:
      - 'null'
      - string
    doc: "assign a label to an image"
    inputBinding:
      position: 20
      prefix: "-label"
  - id: lat
    type:
      - 'null'
      - string
    doc: "local adaptive thresholding"
    inputBinding:
      position: 20
      prefix: "-lat"
  - id: level
    type:
      - 'null'
      - string
    doc: "adjust the level of image contrast"
    inputBinding:
      position: 20
      prefix: "-level"
  - id: limit
    type:
      - 'null'
      - type: array
        items: string
    doc: "Disk, File, Map, Memory, Pixels, Width, Height Threads, Read, or Write resource limit"
    inputBinding:
      position: 20
      prefix: "-limit"
  - id: linewidth
    type:
      - 'null'
      - string
    doc: "the line width for subsequent draw operations"
    inputBinding:
      position: 20
      prefix: "-linewidth"
  - id: log
    type:
      - 'null'
      - string
    doc: "format of debugging information"
    inputBinding:
      position: 20
      prefix: "-log"
  - id: loop
    type:
      - 'null'
      - string
    doc: "add Netscape loop extension to your GIF animation"
    inputBinding:
      position: 20
      prefix: "-loop"
  - id: magnify
    type:
      - 'null'
      - boolean
    doc: "interpolate image to double size"
    inputBinding:
      position: 20
      prefix: "-magnify"
  - id: map
    type:
      - 'null'
      - File
    doc: "transform image colors to match this set of colors"
    inputBinding:
      position: 20
      prefix: "-map"
  - id: mask
    type:
      - 'null'
      - File
    doc: "set the image clip mask"
    inputBinding:
      position: 20
      prefix: "-mask"
  - id: matte
    type:
      - 'null'
      - boolean
    doc: "store matte channel if the image has one"
    inputBinding:
      position: 20
      prefix: "-matte"
  - id: mattecolor
    type:
      - 'null'
      - string
    doc: "specify the color to be used with the -frame option"
    inputBinding:
      position: 20
      prefix: "-mattecolor"
  - id: median
    type:
      - 'null'
      - string
    doc: "apply a median filter to the image"
    inputBinding:
      position: 20
      prefix: "-median"
  - id: minify
    type:
      - 'null'
      - boolean
    doc: "interpolate the image to half size"
    inputBinding:
      position: 20
      prefix: "-minify"
  - id: modulate
    type:
      - 'null'
      - string
    doc: "vary the brightness, saturation, and hue"
    inputBinding:
      position: 20
      prefix: "-modulate"
  - id: monitor
    type:
      - 'null'
      - boolean
    doc: "show progress indication"
    inputBinding:
      position: 20
      prefix: "-monitor"
  - id: monochrome
    type:
      - 'null'
      - boolean
    doc: "transform image to black and white"
    inputBinding:
      position: 20
      prefix: "-monochrome"
  - id: morph
    type:
      - 'null'
      - string
    doc: "morph an image sequence"
    inputBinding:
      position: 20
      prefix: "-morph"
  - id: mosaic
    type:
      - 'null'
      - boolean
    doc: "create a mosaic from an image sequence"
    inputBinding:
      position: 20
      prefix: "-mosaic"
  - id: motion_blur
    type:
      - 'null'
      - string
    doc: "simulate motion blur"
    inputBinding:
      position: 20
      prefix: "-motion-blur"
  - id: negate
    type:
      - 'null'
      - boolean
    doc: "replace every pixel with its complementary color"
    inputBinding:
      position: 20
      prefix: "-negate"
  - id: noop
    type:
      - 'null'
      - boolean
    doc: "do not apply options to image"
    inputBinding:
      position: 20
      prefix: "-noop"
  - id: noise
    type:
      - 'null'
      - string
    doc: "add or reduce noise in an image"
    inputBinding:
      position: 20
      prefix: "-noise"
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: "transform image to span the full range of colors"
    inputBinding:
      position: 20
      prefix: "-normalize"
  - id: opaque
    type:
      - 'null'
      - string
    doc: "change this color to the fill color"
    inputBinding:
      position: 20
      prefix: "-opaque"
  - id: operator
    type:
      - 'null'
      - type: array
        items: string
    doc: "apply a mathematical or bitwise operator to channel"
    inputBinding:
      position: 20
      prefix: "-operator"
  - id: ordered_dither
    type:
      - 'null'
      - type: array
        items: string
    doc: "ordered dither the image"
    inputBinding:
      position: 20
      prefix: "-ordered-dither"
  - id: orient
    type:
      - 'null'
      - string
    doc: "set image orientation attribute"
    inputBinding:
      position: 20
      prefix: "-orient"
  - id: plus_page
    type:
      - 'null'
      - boolean
    doc: "reset current page offsets to default"
    inputBinding:
      position: 20
      prefix: "+page"
  - id: page
    type:
      - 'null'
      - string
    doc: "size and location of an image canvas"
    inputBinding:
      position: 20
      prefix: "-page"
  - id: paint
    type:
      - 'null'
      - string
    doc: "simulate an oil painting"
    inputBinding:
      position: 20
      prefix: "-paint"
  - id: ping
    type:
      - 'null'
      - boolean
    doc: "efficiently determine image attributes"
    inputBinding:
      position: 5
      prefix: "-ping"
  - id: pointsize
    type:
      - 'null'
      - string
    doc: "font point size"
    inputBinding:
      position: 20
      prefix: "-pointsize"
  - id: preview
    type:
      - 'null'
      - string
    doc: "image preview type"
    inputBinding:
      position: 20
      prefix: "-preview"
  - id: profile
    type:
      - 'null'
      - File
    doc: "add ICM or IPTC information profile to image"
    inputBinding:
      position: 20
      prefix: "-profile"
  - id: quality
    type:
      - 'null'
      - string
    doc: "JPEG/MIFF/PNG compression level"
    inputBinding:
      position: 20
      prefix: "-quality"
  - id: raise
    type:
      - 'null'
      - string
    doc: "lighten/darken image edges to create a 3-D effect"
    inputBinding:
      position: 20
      prefix: "-raise"
  - id: random_threshold
    type:
      - 'null'
      - type: array
        items: string
    doc: "random threshold the image"
    inputBinding:
      position: 20
      prefix: "-random-threshold"
  - id: recolor
    type:
      - 'null'
      - string
    doc: "apply a color translation matrix to image channels"
    inputBinding:
      position: 20
      prefix: "-recolor"
  - id: red_primary
    type:
      - 'null'
      - string
    doc: "chomaticity red primary point"
    inputBinding:
      position: 20
      prefix: "-red-primary"
  - id: region
    type:
      - 'null'
      - string
    doc: "apply options to a portion of the image"
    inputBinding:
      position: 20
      prefix: "-region"
  - id: render
    type:
      - 'null'
      - boolean
    doc: "render vector graphics"
    inputBinding:
      position: 20
      prefix: "-render"
  - id: plus_render
    type:
      - 'null'
      - boolean
    doc: "disable rendering vector graphics"
    inputBinding:
      position: 20
      prefix: "+render"
  - id: resample
    type:
      - 'null'
      - string
    doc: "resample to horizontal and vertical resolution"
    inputBinding:
      position: 20
      prefix: "-resample"
  - id: plus_repage
    type:
      - 'null'
      - boolean
    doc: "reset current page offsets to default"
    inputBinding:
      position: 20
      prefix: "+repage"
  - id: repage
    type:
      - 'null'
      - string
    doc: "adjust current page offsets by geometry"
    inputBinding:
      position: 20
      prefix: "-repage"
  - id: resize
    type:
      - 'null'
      - string
    doc: "resize the image"
    inputBinding:
      position: 20
      prefix: "-resize"
  - id: roll
    type:
      - 'null'
      - string
    doc: "roll an image vertically or horizontally"
    inputBinding:
      position: 20
      prefix: "-roll"
  - id: rotate
    type:
      - 'null'
      - string
    doc: "apply Paeth rotation to the image"
    inputBinding:
      position: 20
      prefix: "-rotate"
  - id: sample
    type:
      - 'null'
      - string
    doc: "scale image with pixel sampling"
    inputBinding:
      position: 20
      prefix: "-sample"
  - id: sampling_factor
    type:
      - 'null'
      - string
    doc: "horizontal and vertical sampling factors"
    inputBinding:
      position: 5
      prefix: "-sampling-factor"
  - id: scale
    type:
      - 'null'
      - string
    doc: "scale the image"
    inputBinding:
      position: 20
      prefix: "-scale"
  - id: scene
    type:
      - 'null'
      - string
    doc: "image scene number"
    inputBinding:
      position: 20
      prefix: "-scene"
  - id: seed
    type:
      - 'null'
      - string
    doc: "pseudo-random number generator seed value"
    inputBinding:
      position: 20
      prefix: "-seed"
  - id: segment
    type:
      - 'null'
      - string
    doc: "segment an image"
    inputBinding:
      position: 20
      prefix: "-segment"
  - id: set
    type:
      - 'null'
      - type: array
        items: string
    doc: "set image attribute"
    inputBinding:
      position: 20
      prefix: "-set"
  - id: plus_set
    type:
      - 'null'
      - string
    doc: "unset image attribute"
    inputBinding:
      position: 20
      prefix: "+set"
  - id: shade
    type:
      - 'null'
      - string
    doc: "shade the image using a distant light source"
    inputBinding:
      position: 20
      prefix: "-shade"
  - id: sharpen
    type:
      - 'null'
      - string
    doc: "sharpen the image"
    inputBinding:
      position: 20
      prefix: "-sharpen"
  - id: shave
    type:
      - 'null'
      - string
    doc: "shave pixels from the image edges"
    inputBinding:
      position: 20
      prefix: "-shave"
  - id: shear
    type:
      - 'null'
      - string
    doc: "slide one edge of the image along the X or Y axis"
    inputBinding:
      position: 20
      prefix: "-shear"
  - id: size
    type:
      - 'null'
      - string
    doc: "width and height of image"
    inputBinding:
      position: 5
      prefix: "-size"
  - id: solarize
    type:
      - 'null'
      - string
    doc: "negate all pixels above the threshold level"
    inputBinding:
      position: 20
      prefix: "-solarize"
  - id: spread
    type:
      - 'null'
      - string
    doc: "displace image pixels by a random amount"
    inputBinding:
      position: 20
      prefix: "-spread"
  - id: stroke
    type:
      - 'null'
      - string
    doc: "graphic primitive stroke color"
    inputBinding:
      position: 20
      prefix: "-stroke"
  - id: strokewidth
    type:
      - 'null'
      - string
    doc: "graphic primitive stroke width"
    inputBinding:
      position: 20
      prefix: "-strokewidth"
  - id: strip
    type:
      - 'null'
      - boolean
    doc: "strip all profiles and text attributes from image"
    inputBinding:
      position: 20
      prefix: "-strip"
  - id: swirl
    type:
      - 'null'
      - string
    doc: "swirl image pixels about the center"
    inputBinding:
      position: 20
      prefix: "-swirl"
  - id: texture
    type:
      - 'null'
      - File
    doc: "name of texture to tile onto the image background"
    inputBinding:
      position: 20
      prefix: "-texture"
  - id: threshold
    type:
      - 'null'
      - string
    doc: "threshold the image"
    inputBinding:
      position: 20
      prefix: "-threshold"
  - id: thumbnail
    type:
      - 'null'
      - string
    doc: "resize the image (optimized for thumbnails)"
    inputBinding:
      position: 20
      prefix: "-thumbnail"
  - id: tile
    type:
      - 'null'
      - File
    doc: "tile image when filling a graphic primitive"
    inputBinding:
      position: 20
      prefix: "-tile"
  - id: transform
    type:
      - 'null'
      - boolean
    doc: "affine transform image"
    inputBinding:
      position: 20
      prefix: "-transform"
  - id: transparent
    type:
      - 'null'
      - string
    doc: "make this color transparent within the image"
    inputBinding:
      position: 20
      prefix: "-transparent"
  - id: treedepth
    type:
      - 'null'
      - string
    doc: "color tree depth"
    inputBinding:
      position: 20
      prefix: "-treedepth"
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "trim image edges"
    inputBinding:
      position: 20
      prefix: "-trim"
  - id: type
    type:
      - 'null'
      - string
    doc: "image type"
    inputBinding:
      position: 20
      prefix: "-type"
  - id: undercolor
    type:
      - 'null'
      - string
    doc: "annotation bounding box color"
    inputBinding:
      position: 20
      prefix: "-undercolor"
  - id: units
    type:
      - 'null'
      - string
    doc: "PixelsPerInch, PixelsPerCentimeter, or Undefined"
    inputBinding:
      position: 20
      prefix: "-units"
  - id: unsharp
    type:
      - 'null'
      - string
    doc: "sharpen the image"
    inputBinding:
      position: 20
      prefix: "-unsharp"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print detailed information about the image"
    inputBinding:
      position: 20
      prefix: "-verbose"
  - id: view
    type:
      - 'null'
      - boolean
    doc: "FlashPix viewing transforms"
    inputBinding:
      position: 20
      prefix: "-view"
  - id: virtual_pixel
    type:
      - 'null'
      - string
    doc: "Constant, Edge, Mirror, or Tile"
    inputBinding:
      position: 20
      prefix: "-virtual-pixel"
  - id: wave
    type:
      - 'null'
      - string
    doc: "alter an image along a sine wave"
    inputBinding:
      position: 20
      prefix: "-wave"
  - id: white_point
    type:
      - 'null'
      - string
    doc: "chomaticity white point"
    inputBinding:
      position: 20
      prefix: "-white-point"
  - id: white_threshold
    type:
      - 'null'
      - string
    doc: "pixels above the threshold become white"
    inputBinding:
      position: 20
      prefix: "-white-threshold"
  - id: write
    type:
      - 'null'
      - string
    doc: "write image to this file"
    inputBinding:
      position: 20
      prefix: "-write"
outputs:
  - id: output_image
    type:
      - 'null'
      - File
    doc: Converted image (a sequence written to one file name per frame is not collected here)
    outputBinding:
      glob: $(inputs.output_file)
  - id: write_image
    type:
      - 'null'
      - File
    doc: Image written with the -write option
    outputBinding:
      glob: $(inputs.write)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_convert.out
