cwlVersion: v1.2
class: CommandLineTool
baseCommand: bitmask
label: bart_bitmask
doc: "Convert between a bitmask and set of dimensions.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimensions
    type:
      type: array
      items: string
    doc: set of dimensions
    inputBinding:
      position: 1
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 102
      prefix: -b
  - id: dimensions_from_bitmask
    type:
      - 'null'
      - boolean
    doc: dimensions from bitmask
    inputBinding:
      position: 102
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_bitmask.out
