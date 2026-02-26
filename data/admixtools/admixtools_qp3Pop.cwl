cwlVersion: v1.2
class: CommandLineTool
baseCommand: qp3Pop
label: admixtools_qp3Pop
doc: "Compute the f3-statistic, also known as the 3-population test, to test for admixture
  or shared genetic history.\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: hicount
    type:
      - 'null'
      - int
    doc: hicount -n popfilename
    inputBinding:
      position: 102
      prefix: -H
  - id: locount
    type:
      - 'null'
      - int
    doc: locount -n popfilename
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
  - id: snp_details_name
    type:
      - 'null'
      - string
    doc: use <nam> as snp details name
    inputBinding:
      position: 102
      prefix: -f
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
stdout: admixtools_qp3Pop.out
