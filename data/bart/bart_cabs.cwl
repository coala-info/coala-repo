cwlVersion: v1.2
class: CommandLineTool
baseCommand: cabs
label: bart_cabs
doc: "Usage: cabs <input> <output>\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
