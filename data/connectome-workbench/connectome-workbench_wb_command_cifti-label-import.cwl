cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-label-import
label: connectome-workbench_wb_command_cifti-label-import
doc: "Creates a cifti label file from a cifti file with label-like values. You may specify the empty string ('' will work on linux/mac) for <label-list-file>, which will be treated as if it is an empty file. It is assumed that a value of 0 in the input file means \"unlabeled\", unless -unlabeled-value is specified. Do not specify the \"unlabeled\" label in the text file. The label list file must have the following format (2 lines per label): <labelname> <key> <red> <green> <blue> <alpha> ... Label names are specified on a separate line from their value and color, in order to let label names contain spaces. Whitespace is trimmed from both ends of the label name, but is kept if it is in the middle of a label. The value of <key> specifies what value in the imported file should be used as this label. The values of <red>, <green>, <blue> and <alpha> must be integers from 0 to 255, and will specify the color the label is drawn as (alpha of 255 means fully opaque, which is probably what you want). By default, it will create new label names with names like LABEL_5 for any values encountered that are not mentioned in the list file, specify -discard-others to instead set these values to the \"unlabeled\" key.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: input
    type: File
    doc: the input cifti file
    inputBinding:
      position: 1
  - id: label_list_file
    type: File
    doc: text file containing the values and names for labels
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output cifti label file
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
    doc: 'set the value that will be interpreted as unlabeled: the numeric value for unlabeled (default 0)'
    inputBinding:
      position: 5
      prefix: -unlabeled-value
  - id: drop_unused_labels
    type:
      - 'null'
      - boolean
    doc: remove any unused label values from the label table
    inputBinding:
      position: 6
      prefix: -drop-unused-labels
outputs:
  - id: output_file
    type: File
    doc: the output cifti label file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
