cwlVersion: v1.2
class: CommandLineTool
baseCommand: rof
label: bart_rof
doc: "Perform total variation denoising along dims <flags>.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: lambda
    type: float
    doc: lambda
    inputBinding:
      position: 1
  - id: flags
    type: string
    doc: flags
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
