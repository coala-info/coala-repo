cwlVersion: v1.2
class: CommandLineTool
baseCommand: samhead
label: cansam_samhead
doc: "\nTool homepage: https://github.com/jmarshall/cansam"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
stdout: cansam_samhead.out
