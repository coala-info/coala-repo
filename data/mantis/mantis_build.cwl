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
  - id: build_output_path
    type: string
    doc: Output or path parameter `build_output_path`
    inputBinding:
      position: 102
      prefix: --build-output
outputs:
  - id: build_output
    type: Directory
    doc: directory where results should be written
    outputBinding:
      glob: $(inputs.build_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
