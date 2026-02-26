cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpAdm
label: admixtools_qpAdm
doc: "qpAdm is used to estimate the proportions of ancestry from a set of source populations
  for a target population.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: use parameters from <file>
    inputBinding:
      position: 102
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: toggle verbose mode ON
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpAdm.out
