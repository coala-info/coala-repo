cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BandageNG
  - image
label: bandage_ng_image
doc: "Generate an image file of a graph\n\nTool homepage: https://github.com/asl/BandageNG"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: The image file to be created (must end in '.jpg', '.png' or '.svg')
    inputBinding:
      position: 3
  - id: height
    type:
      - 'null'
      - int
    doc: Image height
    inputBinding:
      position: 1
      prefix: --height
  - id: width
    type:
      - 'null'
      - int
    doc: Image width
    inputBinding:
      position: 1
      prefix: --width
  - id: color
    type:
      - 'null'
      - File
    doc: 'csv file with 2 columns: first the node name second the node color'
    inputBinding:
      position: 1
      prefix: --color
outputs:
  - id: image
    type: File
    doc: Graph image (PNG, JPG or SVG)
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
