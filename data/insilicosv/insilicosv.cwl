cwlVersion: v1.2
class: CommandLineTool
baseCommand: insilicosv
label: insilicosv
doc: "insilicoSV is a software to design and simulate complex structural variants,
  both novel and known.\n\nTool homepage: https://github.com/PopicLab/insilicoSV"
inputs:
  - id: config
    type: File
    doc: YAML config file
    inputBinding:
      position: 1
  - id: random_seed
    type:
      - 'null'
      - int
    doc: if non-zero, random seed for random number generation
    inputBinding:
      position: 102
      prefix: --random_seed
  - id: root_directory
    type:
      - 'null'
      - Directory
    doc: root directory for all files given
    inputBinding:
      position: 102
      prefix: --root
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insilicosv:0.0.6--pyhdfd78af_0
stdout: insilicosv.out
