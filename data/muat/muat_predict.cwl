cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat predict
label: muat_predict
doc: "Predicts variants from sequencing data.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: command
    type: string
    doc: 'Available commands. wgs: Whole Genome Sequence., wes: Whole Exome Sequence.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat_predict.out
