cwlVersion: v1.2
class: CommandLineTool
baseCommand: bppseqgen
label: bppsuite_bppseqgen
doc: "Bio++ Sequence Generator\n\nTool homepage: https://github.com/BioPP/bppsuite"
inputs:
  - id: option_file
    type:
      - 'null'
      - File
    doc: param=option_file
    inputBinding:
      position: 101
  - id: parameter1_name
    type:
      - 'null'
      - string
    doc: parameter1_name=parameter1_value
    inputBinding:
      position: 101
  - id: parameter2_name
    type:
      - 'null'
      - type: array
        items: string
    doc: parameter2_name=parameter2_value
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bppsuite:v2.4.1-1-deb_cv1
stdout: bppsuite_bppseqgen.out
