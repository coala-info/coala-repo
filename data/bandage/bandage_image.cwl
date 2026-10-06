cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Bandage
  - image
label: bandage_image
doc: "Bandage image will generate an image file of the graph visualisation without\
  \ opening the GUI.\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 1
  - id: outputfile
    type: string
    doc: The image file to be created (must end in '.jpg', '.png' or '.svg')
    inputBinding:
      position: 2
  - id: height
    type:
      - 'null'
      - int
    doc: 'Image height (default: 1000)'
    inputBinding:
      position: 3
      prefix: --height
  - id: width
    type:
      - 'null'
      - int
    doc: 'Image width (default: not set)'
    inputBinding:
      position: 3
      prefix: --width
  - id: color
    type:
      - 'null'
      - File
    doc: csv file with 2 column first the node name second the node color
    inputBinding:
      position: 3
      prefix: --color
outputs:
  - id: image
    type: File
    doc: Graph image (PNG, JPG or SVG)
    outputBinding:
      glob: $(inputs.outputfile)
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
