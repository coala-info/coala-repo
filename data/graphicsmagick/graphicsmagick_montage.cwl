cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - montage
label: graphicsmagick_montage
doc: "Create a composite image (a grid of tiles) from separate images.\n\nTool homepage: http://www.graphicsmagick.org/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input image files, one per tile
    inputBinding:
      position: 10
  - id: output_file
    type: string
    doc: Output image file name
    inputBinding:
      position: 30
  - id: adjoin
    type:
      - 'null'
      - boolean
    doc: "join images into a single multi-image file"
    inputBinding:
      position: 5
      prefix: "-adjoin"
  - id: affine
    type:
      - 'null'
      - string
    doc: "affine transform matrix"
    inputBinding:
      position: 5
      prefix: "-affine"
  - id: authenticate
    type:
      - 'null'
      - string
    doc: "decrypt image with this password"
    inputBinding:
      position: 5
      prefix: "-authenticate"
  - id: background
    type:
      - 'null'
      - string
    doc: "background color"
    inputBinding:
      position: 5
      prefix: "-background"
  - id: blue_primary
    type:
      - 'null'
      - string
    doc: "chomaticity blue primary point"
    inputBinding:
      position: 5
      prefix: "-blue-primary"
  - id: blur
    type:
      - 'null'
      - string
    doc: "apply a filter to blur the image"
    inputBinding:
      position: 5
      prefix: "-blur"
  - id: bordercolor
    type:
      - 'null'
      - string
    doc: "border color"
    inputBinding:
      position: 5
      prefix: "-bordercolor"
  - id: borderwidth
    type:
      - 'null'
      - string
    doc: "border width"
    inputBinding:
      position: 5
      prefix: "-borderwidth"
  - id: colors
    type:
      - 'null'
      - string
    doc: "preferred number of colors in the image"
    inputBinding:
      position: 5
      prefix: "-colors"
  - id: colorspace
    type:
      - 'null'
      - string
    doc: "alternate image colorsapce"
    inputBinding:
      position: 5
      prefix: "-colorspace"
  - id: comment
    type:
      - 'null'
      - string
    doc: "annotate image with comment"
    inputBinding:
      position: 5
      prefix: "-comment"
  - id: compose
    type:
      - 'null'
      - string
    doc: "composite operator"
    inputBinding:
      position: 5
      prefix: "-compose"
  - id: compress
    type:
      - 'null'
      - string
    doc: "image compression type"
    inputBinding:
      position: 5
      prefix: "-compress"
  - id: crop
    type:
      - 'null'
      - string
    doc: "preferred size and location of the cropped image"
    inputBinding:
      position: 5
      prefix: "-crop"
  - id: debug
    type:
      - 'null'
      - string
    doc: "display copious debugging information"
    inputBinding:
      position: 5
      prefix: "-debug"
  - id: define
    type:
      - 'null'
      - string
    doc: "Coder/decoder specific options"
    inputBinding:
      position: 5
      prefix: "-define"
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
  - id: dispose
    type:
      - 'null'
      - string
    doc: "Undefined, None, Background, Previous"
    inputBinding:
      position: 5
      prefix: "-dispose"
  - id: dither
    type:
      - 'null'
      - boolean
    doc: "apply Floyd/Steinberg error diffusion to image"
    inputBinding:
      position: 5
      prefix: "-dither"
  - id: draw
    type:
      - 'null'
      - string
    doc: "annotate the image with a graphic primitive"
    inputBinding:
      position: 5
      prefix: "-draw"
  - id: encoding
    type:
      - 'null'
      - string
    doc: "text encoding type"
    inputBinding:
      position: 5
      prefix: "-encoding"
  - id: endian
    type:
      - 'null'
      - string
    doc: "multibyte word order (LSB, MSB, or Native)"
    inputBinding:
      position: 5
      prefix: "-endian"
  - id: fill
    type:
      - 'null'
      - string
    doc: "color to use when filling a graphic primitive"
    inputBinding:
      position: 5
      prefix: "-fill"
  - id: filter
    type:
      - 'null'
      - string
    doc: "use this filter when resizing an image"
    inputBinding:
      position: 5
      prefix: "-filter"
  - id: flip
    type:
      - 'null'
      - boolean
    doc: "flip image in the vertical direction"
    inputBinding:
      position: 5
      prefix: "-flip"
  - id: flop
    type:
      - 'null'
      - boolean
    doc: "flop image in the horizontal direction"
    inputBinding:
      position: 5
      prefix: "-flop"
  - id: font
    type:
      - 'null'
      - string
    doc: "font to use when annotating with text"
    inputBinding:
      position: 5
      prefix: "-font"
  - id: format
    type:
      - 'null'
      - string
    doc: "output formatted image characteristics"
    inputBinding:
      position: 5
      prefix: "-format"
  - id: frame
    type:
      - 'null'
      - string
    doc: "surround image with an ornamental border"
    inputBinding:
      position: 5
      prefix: "-frame"
  - id: gamma
    type:
      - 'null'
      - string
    doc: "level of gamma correction"
    inputBinding:
      position: 5
      prefix: "-gamma"
  - id: geometry
    type:
      - 'null'
      - string
    doc: "preferred tile and border sizes"
    inputBinding:
      position: 5
      prefix: "-geometry"
  - id: gravity
    type:
      - 'null'
      - string
    doc: "which direction to gravitate towards"
    inputBinding:
      position: 5
      prefix: "-gravity"
  - id: green_primary
    type:
      - 'null'
      - string
    doc: "chomaticity green primary point"
    inputBinding:
      position: 5
      prefix: "-green-primary"
  - id: interlace
    type:
      - 'null'
      - string
    doc: "None, Line, Plane, or Partition"
    inputBinding:
      position: 5
      prefix: "-interlace"
  - id: label
    type:
      - 'null'
      - string
    doc: "assign a label to an image"
    inputBinding:
      position: 5
      prefix: "-label"
  - id: limit
    type:
      - 'null'
      - type: array
        items: string
    doc: "Disk, File, Map, Memory, Pixels, Width, Height or Threads resource limit"
    inputBinding:
      position: 5
      prefix: "-limit"
  - id: log
    type:
      - 'null'
      - string
    doc: "format of debugging information"
    inputBinding:
      position: 5
      prefix: "-log"
  - id: matte
    type:
      - 'null'
      - boolean
    doc: "store matte channel if the image has one"
    inputBinding:
      position: 5
      prefix: "-matte"
  - id: mattecolor
    type:
      - 'null'
      - string
    doc: "color to be used with the -frame option"
    inputBinding:
      position: 5
      prefix: "-mattecolor"
  - id: mode
    type:
      - 'null'
      - string
    doc: "Frame, Unframe, or Concatenate"
    inputBinding:
      position: 5
      prefix: "-mode"
  - id: monitor
    type:
      - 'null'
      - boolean
    doc: "show progress indication"
    inputBinding:
      position: 5
      prefix: "-monitor"
  - id: monochrome
    type:
      - 'null'
      - boolean
    doc: "transform image to black and white"
    inputBinding:
      position: 5
      prefix: "-monochrome"
  - id: noop
    type:
      - 'null'
      - boolean
    doc: "do not apply options to image"
    inputBinding:
      position: 5
      prefix: "-noop"
  - id: plus_page
    type:
      - 'null'
      - boolean
    doc: "reset current page offsets to default"
    inputBinding:
      position: 5
      prefix: "+page"
  - id: page
    type:
      - 'null'
      - string
    doc: "size and location of an image canvas"
    inputBinding:
      position: 5
      prefix: "-page"
  - id: pointsize
    type:
      - 'null'
      - string
    doc: "font point size"
    inputBinding:
      position: 5
      prefix: "-pointsize"
  - id: quality
    type:
      - 'null'
      - string
    doc: "JPEG/MIFF/PNG compression level"
    inputBinding:
      position: 5
      prefix: "-quality"
  - id: red_primary
    type:
      - 'null'
      - string
    doc: "chomaticity red primary point"
    inputBinding:
      position: 5
      prefix: "-red-primary"
  - id: plus_repage
    type:
      - 'null'
      - boolean
    doc: "reset current page offsets to default"
    inputBinding:
      position: 5
      prefix: "+repage"
  - id: repage
    type:
      - 'null'
      - string
    doc: "adjust current page offsets by geometry"
    inputBinding:
      position: 5
      prefix: "-repage"
  - id: resize
    type:
      - 'null'
      - string
    doc: "resize the image"
    inputBinding:
      position: 5
      prefix: "-resize"
  - id: rotate
    type:
      - 'null'
      - string
    doc: "apply Paeth rotation to the image"
    inputBinding:
      position: 5
      prefix: "-rotate"
  - id: sampling_factor
    type:
      - 'null'
      - string
    doc: "horizontal and vertical sampling factors"
    inputBinding:
      position: 5
      prefix: "-sampling-factor"
  - id: scenes
    type:
      - 'null'
      - string
    doc: "image scene range"
    inputBinding:
      position: 5
      prefix: "-scenes"
  - id: set
    type:
      - 'null'
      - type: array
        items: string
    doc: "set image attribute"
    inputBinding:
      position: 5
      prefix: "-set"
  - id: plus_set
    type:
      - 'null'
      - string
    doc: "unset image attribute"
    inputBinding:
      position: 5
      prefix: "+set"
  - id: shadow
    type:
      - 'null'
      - boolean
    doc: "add a shadow beneath a tile to simulate depth"
    inputBinding:
      position: 5
      prefix: "-shadow"
  - id: sharpen
    type:
      - 'null'
      - string
    doc: "sharpen the image"
    inputBinding:
      position: 5
      prefix: "-sharpen"
  - id: size
    type:
      - 'null'
      - string
    doc: "width and height of image"
    inputBinding:
      position: 5
      prefix: "-size"
  - id: strip
    type:
      - 'null'
      - boolean
    doc: "strip all profiles and text attributes from image"
    inputBinding:
      position: 5
      prefix: "-strip"
  - id: stroke
    type:
      - 'null'
      - string
    doc: "color to use when stroking a graphic primitive"
    inputBinding:
      position: 5
      prefix: "-stroke"
  - id: strokewidth
    type:
      - 'null'
      - string
    doc: "stroke (line) width"
    inputBinding:
      position: 5
      prefix: "-strokewidth"
  - id: texture
    type:
      - 'null'
      - File
    doc: "name of texture to tile onto the image background"
    inputBinding:
      position: 5
      prefix: "-texture"
  - id: thumbnail
    type:
      - 'null'
      - string
    doc: "resize the image (optimized for thumbnails)"
    inputBinding:
      position: 5
      prefix: "-thumbnail"
  - id: tile
    type:
      - 'null'
      - string
    doc: "number of tiles per row and column"
    inputBinding:
      position: 5
      prefix: "-tile"
  - id: title
    type:
      - 'null'
      - string
    doc: "thumbnail title"
    inputBinding:
      position: 5
      prefix: "-title"
  - id: transform
    type:
      - 'null'
      - boolean
    doc: "affine transform image"
    inputBinding:
      position: 5
      prefix: "-transform"
  - id: transparent
    type:
      - 'null'
      - string
    doc: "make this color transparent within the image"
    inputBinding:
      position: 5
      prefix: "-transparent"
  - id: treedepth
    type:
      - 'null'
      - string
    doc: "color tree depth"
    inputBinding:
      position: 5
      prefix: "-treedepth"
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "trim image edges"
    inputBinding:
      position: 5
      prefix: "-trim"
  - id: type
    type:
      - 'null'
      - string
    doc: "image type"
    inputBinding:
      position: 5
      prefix: "-type"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print detailed information about the image"
    inputBinding:
      position: 5
      prefix: "-verbose"
  - id: virtual_pixel
    type:
      - 'null'
      - string
    doc: "Constant, Edge, Mirror, or Tile"
    inputBinding:
      position: 5
      prefix: "-virtual-pixel"
  - id: white_point
    type:
      - 'null'
      - string
    doc: "chomaticity white point"
    inputBinding:
      position: 5
      prefix: "-white-point"
outputs:
  - id: output_image
    type: File
    doc: Montage image
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_montage.out
