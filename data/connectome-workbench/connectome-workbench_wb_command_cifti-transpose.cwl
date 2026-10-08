cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-transpose'
label: connectome-workbench_wb_command_cifti-transpose
doc: "Transpose a cifti file. The input must be a 2-dimensional cifti file. The output is a cifti file where every row in the input is a column in the output.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti file
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: output - the output cifti file
    inputBinding:
      position: 2
  - id: mem_limit
    type:
      - 'null'
      - float
    doc: restrict memory usage, limit in gigabytes
    inputBinding:
      position: 3
      prefix: '-mem-limit'
outputs:
  - id: transposed_cifti
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
