cwlVersion: v1.2
class: CommandLineTool
baseCommand: carg
label: bart_carg
doc: "Processes input and output files.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
