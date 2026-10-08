cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-mask
label: connectome-workbench_wb_command_metric-mask
doc: 'By default, the output metric is a copy of the input metric, but with zeros
  wherever the mask metric is zero or negative. if -column is specified, the output
  contains only one column, the masked version of the specified input column.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: metric
    type: File
    doc: the input metric
    inputBinding:
      position: 1
  - id: mask
    type: File
    doc: the mask metric
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column
    inputBinding:
      position: 4
      prefix: -column
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
