cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, bitmask]
requirements:
  - class: InlineJavascriptRequirement
label: bart_bitmask
doc: "Convert between a bitmask and set of dimensions.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimensions
    type:
      type: array
      items: string
    doc: Dimensions, or one bitmask when -b is set
    inputBinding:
      position: 10
  - id: dimensions_from_bitmask
    type:
      - 'null'
      - boolean
    doc: dimensions from bitmask
    inputBinding:
      position: 1
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_bitmask.out
