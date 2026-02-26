cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_flip
label: bart_flip
doc: "Flip (reverse) dimensions specified by the {bitmask}.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: Bitmask specifying dimensions to flip
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
