cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize
label: bart_normalize
doc: "Normalize input data\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for normalization
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
