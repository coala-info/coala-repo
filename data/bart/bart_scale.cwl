cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_scale
label: bart_scale
doc: "Scale array by {factor}. The scale factor can be a complex number.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: factor
    type: string
    doc: Scale factor
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input array
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output array
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
