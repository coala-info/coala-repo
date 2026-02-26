cwlVersion: v1.2
class: CommandLineTool
baseCommand: mupbwt
label: mupbwt
doc: "mupbwt\n\nTool homepage: https://github.com/dlcgold/muPBWT"
inputs:
  - id: details
    type:
      - 'null'
      - boolean
    doc: print memory usage details
    inputBinding:
      position: 101
      prefix: --details
  - id: input_file
    type:
      - 'null'
      - File
    doc: macs file for panel
    inputBinding:
      position: 101
      prefix: --input_file
  - id: load
    type:
      - 'null'
      - File
    doc: path to load serialization
    inputBinding:
      position: 101
      prefix: --load
  - id: macs
    type:
      - 'null'
      - boolean
    doc: use macs format for panel and queries
    inputBinding:
      position: 101
      prefix: --macs
  - id: query
    type:
      - 'null'
      - File
    doc: path to macs query file
    inputBinding:
      position: 101
      prefix: --query
  - id: save
    type:
      - 'null'
      - File
    doc: path to save serialization
    inputBinding:
      position: 101
      prefix: --save
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: extra prints
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: path to query output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mupbwt:0.1.2--h6ab5fc9_2
