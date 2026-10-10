cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotate
label: mummer4_annotate
doc: "Annotate a gap file with the information of a data file.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: gapfile
    type: File
    doc: Gap file
    inputBinding:
      position: 1
  - id: datafile
    type: File
    doc: Data file
    inputBinding:
      position: 2
outputs:
  - id: annotated
    type: stdout
    doc: Annotated gaps (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_annotate.out
