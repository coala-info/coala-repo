cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpDstat
label: admixtools_qpDstat
doc: "Compute D-statistics for population genetics analysis\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: input_file
    type: File
    doc: Input file for qpDstat
    inputBinding:
      position: 1
  - id: high_value
    type:
      - 'null'
      - float
    doc: use <val> as high value
    inputBinding:
      position: 102
      prefix: -H
  - id: low_value
    type:
      - 'null'
      - float
    doc: use <val> as low value
    inputBinding:
      position: 102
      prefix: -L
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
stdout: admixtools_qpDstat.out
