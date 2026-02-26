cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat_predict-ensemble
label: muat_predict-ensemble
doc: "Predicts variants using an ensemble of models.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: command
    type: string
    doc: 'Available commands. muat-wgs: MuAt Whole Genome Sequence., muat-wes: MuAt
      Whole Exome Sequence.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat_predict-ensemble.out
