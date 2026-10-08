cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - compare
label: graphicsmagick_compare
doc: "Compare two images and report the difference (for example with -metric MAE or PSNR).\n\nTool homepage: http://www.graphicsmagick.org/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: reference
    type: File
    doc: Reference image
    inputBinding:
      position: 10
  - id: compare_image
    type: File
    doc: Image to compare with the reference
    inputBinding:
      position: 30
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
    doc: "orient (rotate) images so they are upright"
    inputBinding:
      position: 5
      prefix: "-auto-orient"
  - id: colorspace
    type:
      - 'null'
      - string
    doc: "alternate image colorspace"
    inputBinding:
      position: 5
      prefix: "-colorspace"
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
    doc: "coder/decoder specific options"
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
  - id: endian
    type:
      - 'null'
      - string
    doc: "multibyte word order (LSB, MSB, or Native)"
    inputBinding:
      position: 5
      prefix: "-endian"
  - id: file
    type:
      - 'null'
      - string
    doc: "write difference image to this file"
    inputBinding:
      position: 5
      prefix: "-file"
  - id: highlight_color
    type:
      - 'null'
      - string
    doc: "color to use when annotating difference pixels"
    inputBinding:
      position: 5
      prefix: "-highlight-color"
  - id: highlight_style
    type:
      - 'null'
      - string
    doc: "pixel highlight style (assign, threshold, tint, xor)"
    inputBinding:
      position: 5
      prefix: "-highlight-style"
  - id: interlace
    type:
      - 'null'
      - string
    doc: "None, Line, Plane, or Partition"
    inputBinding:
      position: 5
      prefix: "-interlace"
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
  - id: maximum_error
    type:
      - 'null'
      - string
    doc: "maximum total difference before returning error"
    inputBinding:
      position: 5
      prefix: "-maximum-error"
  - id: metric
    type:
      - 'null'
      - string
    doc: "comparison metric (MAE, MSE, PAE, PSNR, RMSE)"
    inputBinding:
      position: 5
      prefix: "-metric"
  - id: monitor
    type:
      - 'null'
      - boolean
    doc: "show progress indication"
    inputBinding:
      position: 5
      prefix: "-monitor"
  - id: sampling_factor
    type:
      - 'null'
      - string
    doc: "horizontal and vertical sampling factors"
    inputBinding:
      position: 5
      prefix: "-sampling-factor"
  - id: size
    type:
      - 'null'
      - string
    doc: "width and height of image"
    inputBinding:
      position: 5
      prefix: "-size"
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
outputs:
  - id: difference_image
    type:
      - 'null'
      - File
    doc: Difference image written with the -file option
    outputBinding:
      glob: $(inputs.file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
successCodes: [0, 1]
stdout: graphicsmagick_compare.out
