cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, itsense]
requirements:
  - class: InlineJavascriptRequirement
label: bart_itsense
doc: "A simplified implementation of iterative sense reconstruction\nwith l2-regularization.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: alpha
    type: float
    doc: alpha
    inputBinding:
      position: 10
  - id: sensitivities
    type: File
    doc: sensitivities
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: pattern
    type: File
    doc: pattern
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: image
    type: string
    doc: image
    inputBinding:
      position: 14
outputs:
  - id: image_file
    type: File
    doc: Array written as image.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.image).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
