cwlVersion: v1.2
class: CommandLineTool
baseCommand: bppml
label: bppsuite_bppml
doc: "Bio++ Maximum Likelihood Computation\n\nTool homepage: https://github.com/BioPP/bppsuite"
inputs:
  - id: option_file
    type:
      - 'null'
      - File
    doc: Refer to the Bio++ Program Suite Manual for a list of available 
      options.
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
stdout: bppsuite_bppml.out
