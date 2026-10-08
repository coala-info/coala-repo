cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gm
  - identify
label: graphicsmagick_identify
doc: "Describe the format and characteristics of one or more image files.\n\nTool homepage: http://www.graphicsmagick.org/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Image file(s) to describe
    inputBinding:
      position: 30
  - id: debug
    type:
      - 'null'
      - string
    doc: "display copious debugging information"
    inputBinding:
      position: 20
      prefix: "-debug"
  - id: define
    type:
      - 'null'
      - string
    doc: "Coder/decoder specific options"
    inputBinding:
      position: 20
      prefix: "-define"
  - id: density
    type:
      - 'null'
      - string
    doc: "horizontal and vertical density of the image"
    inputBinding:
      position: 20
      prefix: "-density"
  - id: depth
    type:
      - 'null'
      - string
    doc: "image depth"
    inputBinding:
      position: 20
      prefix: "-depth"
  - id: format
    type:
      - 'null'
      - string
    doc: "output formatted image characteristics"
    inputBinding:
      position: 20
      prefix: "-format"
  - id: interlace
    type:
      - 'null'
      - string
    doc: "None, Line, Plane, or Partition"
    inputBinding:
      position: 20
      prefix: "-interlace"
  - id: limit
    type:
      - 'null'
      - type: array
        items: string
    doc: "Disk, File, Map, Memory, Pixels, Width, Height or Threads resource limit"
    inputBinding:
      position: 20
      prefix: "-limit"
  - id: log
    type:
      - 'null'
      - string
    doc: "format of debugging information"
    inputBinding:
      position: 20
      prefix: "-log"
  - id: monitor
    type:
      - 'null'
      - boolean
    doc: "show progress indication"
    inputBinding:
      position: 20
      prefix: "-monitor"
  - id: ping
    type:
      - 'null'
      - boolean
    doc: "efficiently determine image attributes"
    inputBinding:
      position: 20
      prefix: "-ping"
  - id: sampling_factor
    type:
      - 'null'
      - string
    doc: "horizontal and vertical sampling factors"
    inputBinding:
      position: 20
      prefix: "-sampling-factor"
  - id: size
    type:
      - 'null'
      - string
    doc: "width and height of image"
    inputBinding:
      position: 20
      prefix: "-size"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print detailed information about the image"
    inputBinding:
      position: 20
      prefix: "-verbose"
  - id: virtual_pixel
    type:
      - 'null'
      - string
    doc: "Constant, Edge, Mirror, or Tile"
    inputBinding:
      position: 20
      prefix: "-virtual-pixel"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphicsmagick:1.3.46
stdout: graphicsmagick_identify.out
