cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-label-import
label: connectome-workbench_wb_command_metric-label-import
doc: 'Creates a new gifti label file from a metric file with label-like values. You
  may specify the empty string ('''' will work on linux/mac) for <label-list-file>,
  which will be treated as if it is an empty file. The label list file must have lines
  of the following format:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: input
    type: File
    doc: the input metric file
    inputBinding:
      position: 1
  - id: label_list_file
    type: File
    doc: text file containing the values and names for labels
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output - the output gifti label file
    inputBinding:
      position: 3
  - id: discard_others
    type:
      - 'null'
      - boolean
    doc: set any values not mentioned in the label list to the ??? label
    inputBinding:
      position: 4
      prefix: -discard-others
  - id: unlabeled_value
    type:
      - 'null'
      - int
    doc: set the value that will be interpreted as unlabeled
    inputBinding:
      position: 4
      prefix: -unlabeled-value
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to import
    inputBinding:
      position: 4
      prefix: -column
  - id: drop_unused_labels
    type:
      - 'null'
      - boolean
    doc: remove any unused label values from the label table
    inputBinding:
      position: 4
      prefix: -drop-unused-labels
outputs:
  - id: output_file
    type: File
    doc: the output gifti label file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
