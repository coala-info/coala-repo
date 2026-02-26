cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmac
label: bart_fmac
doc: "Multiply <input1> and <input2> and accumulate in <output>. If <input2> is not
  specified, assume all-ones.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input1
    type: File
    doc: First input file
    inputBinding:
      position: 1
  - id: input2
    type:
      - 'null'
      - File
    doc: Second input file (optional, defaults to all-ones)
    inputBinding:
      position: 2
  - id: add_to_existing
    type:
      - 'null'
      - boolean
    doc: add to existing output (instead of overwriting)
    inputBinding:
      position: 103
      prefix: -A
  - id: conjugate_input2
    type:
      - 'null'
      - boolean
    doc: conjugate input2
    inputBinding:
      position: 103
      prefix: -C
  - id: squash_dimensions
    type:
      - 'null'
      - string
    doc: squash dimensions selected by bitmask b
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
