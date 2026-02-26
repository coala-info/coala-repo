cwlVersion: v1.2
class: CommandLineTool
baseCommand: saxpy
label: bart_saxpy
doc: "Multiply input1 with scale factor and add input2.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: scale
    type: string
    doc: scale
    inputBinding:
      position: 1
  - id: input1
    type: string
    doc: input1
    inputBinding:
      position: 2
  - id: input2
    type: string
    doc: input2
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_saxpy.out
