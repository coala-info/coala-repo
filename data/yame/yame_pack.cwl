cwlVersion: v1.2
class: CommandLineTool
baseCommand: yame_pack
label: yame_pack
doc: "Pack tab-delimited text into a compressed cx file.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_file
    type: File
    doc: Input tab-delimited text file
    inputBinding:
      position: 1
  - id: bytes_per_unit
    type:
      - 'null'
      - int
    doc: Number of bytes per unit when inflated (1-8). 0 - infer from data.
    inputBinding:
      position: 102
      prefix: -u
  - id: format
    type:
      - 'null'
      - string
    doc: Format specification (one of b,c,s,m,d,n,r)
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output compressed cx file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
