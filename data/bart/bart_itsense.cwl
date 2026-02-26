cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bart
  - itsense
  - alpha
label: bart_itsense
doc: "A simplified implementation of iterative sense reconstruction\nwith l2-regularization.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: sensitivities
    type: File
    doc: sensitivities
    inputBinding:
      position: 1
  - id: kspace
    type: File
    doc: kspace
    inputBinding:
      position: 2
  - id: pattern
    type: File
    doc: pattern
    inputBinding:
      position: 3
  - id: image
    type: File
    doc: image
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_itsense.out
