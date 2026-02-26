cwlVersion: v1.2
class: CommandLineTool
baseCommand: avg
label: bart_avg
doc: "Calculates (weighted) average along dimensions specified by bitmask.\n\nTool
  homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: Bitmask specifying dimensions for averaging
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 2
  - id: weighted_average
    type:
      - 'null'
      - boolean
    doc: weighted average
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
