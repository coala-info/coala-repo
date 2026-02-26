cwlVersion: v1.2
class: CommandLineTool
baseCommand: bppancestor
label: bppsuite_bppancestor
doc: "Bio++ Ancestral Sequence Reconstruction\n\nTool homepage: https://github.com/BioPP/bppsuite"
inputs:
  - id: param
    type:
      - 'null'
      - File
    doc: option_file
    inputBinding:
      position: 101
  - id: parameter1_name
    type:
      - 'null'
      - string
    doc: parameter1_value
    inputBinding:
      position: 101
  - id: parameter2_name
    type:
      - 'null'
      - string
    doc: parameter2_value
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bppsuite:v2.4.1-1-deb_cv1
stdout: bppsuite_bppancestor.out
