cwlVersion: v1.2
class: CommandLineTool
baseCommand: noise
label: bart_noise
doc: "Add noise with selected variance to input.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: random_seed
    type:
      - 'null'
      - string
    doc: random seed initialization
    inputBinding:
      position: 102
      prefix: -s
  - id: real_valued_input
    type:
      - 'null'
      - boolean
    doc: real-valued input
    inputBinding:
      position: 102
      prefix: -r
  - id: variance
    type:
      - 'null'
      - float
    doc: variance
    default: 1.0
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
