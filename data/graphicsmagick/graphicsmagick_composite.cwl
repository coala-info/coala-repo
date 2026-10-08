cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - composite
label: graphicsmagick_composite
doc: "Overlay one image over another, optionally through a mask, with a composite operator.\n\nTool homepage: http://www.graphicsmagick.org/"
inputs:
  - id: change_image
    type: File
    doc: Image to composite over the base image (the overlay)
    inputBinding:
      position: 10
  - id: base_image
    type: File
    doc: Base image
    inputBinding:
      position: 11
  - id: mask_image
    type:
      - 'null'
      - File
    doc: Optional mask image
    inputBinding:
      position: 12
  - id: output_file
    type: string
    doc: Output image file name
    inputBinding:
      position: 30
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
  - id: blue_primary
    type:
      - 'null'
      - string
    doc: "chomaticity blue primary point"
    inputBinding:
      position: 5
      prefix: "-blue-primary"
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
    doc: "alternate image colorspace"
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
  - id: displace
    type:
      - 'null'
      - string
    doc: "shift image pixels defined by a displacement map"
    inputBinding:
      position: 5
      prefix: "-displace"
  - id: dispose
    type:
      - 'null'
      - string
    doc: "Undefined, None, Background, Previous"
    inputBinding:
      position: 5
      prefix: "-dispose"
  - id: dissolve
    type:
      - 'null'
      - string
    doc: "dissolve the two images a given percent"
    inputBinding:
      position: 5
      prefix: "-dissolve"
  - id: dither
    type:
      - 'null'
      - boolean
    doc: "apply Floyd/Steinberg error diffusion to image"
    inputBinding:
      position: 5
      prefix: "-dither"
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
  - id: filter
    type:
      - 'null'
      - string
    doc: "use this filter when resizing an image"
    inputBinding:
      position: 5
      prefix: "-filter"
  - id: font
    type:
      - 'null'
      - string
    doc: "render text with this font"
    inputBinding:
      position: 5
      prefix: "-font"
  - id: geometry
    type:
      - 'null'
      - string
    doc: "location of the composite image"
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
    doc: "ssign a label to an image"
    inputBinding:
      position: 5
      prefix: "-label"
  - id: limit
    type:
      - 'null'
      - type: array
        items: string
    doc: "Disk, File, Map, Memory, Pixels, Width, Height Threads, Read, or Write resource limit"
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
  - id: negate
    type:
      - 'null'
      - boolean
    doc: "replace every pixel with its complementary color"
    inputBinding:
      position: 5
      prefix: "-negate"
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
  - id: profile
    type:
      - 'null'
      - File
    doc: "add ICM or IPTC information profile to image"
    inputBinding:
      position: 5
      prefix: "-profile"
  - id: quality
    type:
      - 'null'
      - string
    doc: "JPEG/MIFF/PNG compression level"
    inputBinding:
      position: 5
      prefix: "-quality"
  - id: recolor
    type:
      - 'null'
      - string
    doc: "apply a color translation matrix to image channels"
    inputBinding:
      position: 5
      prefix: "-recolor"
  - id: red_primary
    type:
      - 'null'
      - string
    doc: "chomaticity red primary point"
    inputBinding:
      position: 5
      prefix: "-red-primary"
  - id: rotate
    type:
      - 'null'
      - string
    doc: "apply Paeth rotation to the image"
    inputBinding:
      position: 5
      prefix: "-rotate"
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
  - id: sampling_factor
    type:
      - 'null'
      - string
    doc: "horizontal and vertical sampling factors"
    inputBinding:
      position: 5
      prefix: "-sampling-factor"
  - id: scene
    type:
      - 'null'
      - string
    doc: "image scene number"
    inputBinding:
      position: 5
      prefix: "-scene"
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
  - id: stegano
    type:
      - 'null'
      - string
    doc: "hide watermark within an image"
    inputBinding:
      position: 5
      prefix: "-stegano"
  - id: stereo
    type:
      - 'null'
      - boolean
    doc: "combine two image to create a stereo anaglyph"
    inputBinding:
      position: 5
      prefix: "-stereo"
  - id: strip
    type:
      - 'null'
      - boolean
    doc: "strip all profiles and text attributes from image"
    inputBinding:
      position: 5
      prefix: "-strip"
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
      - boolean
    doc: "repeat composite operation across image"
    inputBinding:
      position: 5
      prefix: "-tile"
  - id: transform
    type:
      - 'null'
      - boolean
    doc: "affine transform image"
    inputBinding:
      position: 5
      prefix: "-transform"
  - id: treedepth
    type:
      - 'null'
      - string
    doc: "color tree depth"
    inputBinding:
      position: 5
      prefix: "-treedepth"
  - id: type
    type:
      - 'null'
      - string
    doc: "image type"
    inputBinding:
      position: 5
      prefix: "-type"
  - id: units
    type:
      - 'null'
      - string
    doc: "PixelsPerInch, PixelsPerCentimeter, or Undefined"
    inputBinding:
      position: 5
      prefix: "-units"
  - id: unsharp
    type:
      - 'null'
      - string
    doc: "sharpen the image"
    inputBinding:
      position: 5
      prefix: "-unsharp"
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
  - id: watermark
    type:
      - 'null'
      - string
    doc: "percent brightness and saturation of a watermark"
    inputBinding:
      position: 5
      prefix: "-watermark"
  - id: white_point
    type:
      - 'null'
      - string
    doc: "chomaticity white point"
    inputBinding:
      position: 5
      prefix: "-white-point"
  - id: write
    type:
      - 'null'
      - string
    doc: "write image to this file"
    inputBinding:
      position: 5
      prefix: "-write"
outputs:
  - id: output_image
    type: File
    doc: Composited image
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_composite.out
