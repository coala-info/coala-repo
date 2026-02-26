cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis build
label: mantis_build
doc: "Build a CQF (Compressed Quotient Filter) from input filters.\n\nTool homepage:
  https://github.com/splatlab/mantis"
inputs:
  - id: eqclass_dist
    type:
      - 'null'
      - boolean
    doc: write the eqclass abundance distribution
    inputBinding:
      position: 101
      prefix: --eqclass_dist
  - id: input_list
    type: File
    doc: file containing list of input filters
    inputBinding:
      position: 101
      prefix: -i
  - id: log_slots
    type: string
    doc: log of number of slots in the output CQF
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: build_output
    type: Directory
    doc: directory where results should be written
    outputBinding:
      glob: $(inputs.build_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
