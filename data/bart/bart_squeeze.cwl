cwlVersion: v1.2
class: CommandLineTool
baseCommand: squeeze
label: bart_squeeze
doc: "Squeezes a BART file.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input BART file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output BART file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
