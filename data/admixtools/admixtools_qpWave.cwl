cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpWave
label: admixtools_qpWave
doc: "qpWave is a tool for testing whether a set of 'left' populations is consistent
  with being descended from a specified number of waves of admixture relative to a
  set of 'right' populations.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: parameter_file
    type: File
    doc: Input parameter file
    inputBinding:
      position: 1
  - id: params
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
stdout: admixtools_qpWave.out
