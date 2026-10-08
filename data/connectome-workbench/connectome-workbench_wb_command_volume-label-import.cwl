cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-label-import
label: connectome-workbench_wb_command_volume-label-import
doc: "Creates a new label volume from an integer-valued volume file. The label name and color information is stored in the volume header in a nifti extension, with a similar format as in caret5, see -volume-help. You may specify the empty string ('' will work on linux/mac) for <label-list-file>, which will be treated as if it is an empty file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: input
    type: File
    doc: "the input volume file"
    inputBinding:
      position: 1
  - id: label_list_file
    type: File
    doc: "text file containing the values and names for labels"
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "output - the output workbench label volume"
    inputBinding:
      position: 3
  - id: discard_others
    type:
      - 'null'
      - boolean
    doc: "set any voxels with values not mentioned in the label list to the ??? label"
    inputBinding:
      position: 4
      prefix: -discard-others
  - id: unlabeled_value
    type:
      - 'null'
      - int
    doc: "set the value that will be interpreted as unlabeled: the numeric value for unlabeled (default 0)"
    inputBinding:
      position: 5
      prefix: -unlabeled-value
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to import: the subvolume number or name"
    inputBinding:
      position: 6
      prefix: -subvolume
  - id: drop_unused_labels
    type:
      - 'null'
      - boolean
    doc: "remove any unused label values from the label table"
    inputBinding:
      position: 7
      prefix: -drop-unused-labels
outputs:
  - id: label_volume
    type: File
    doc: "the output workbench label volume"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
