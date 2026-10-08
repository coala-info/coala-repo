cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-create-label
label: connectome-workbench_wb_command_cifti-create-label
doc: "All input files must have the same number of columns/subvolumes. Only the specified components will be in the output cifti. At least one component must be specified. The -volume option requires two volume arguments, the label-volume argument contains all labels you want to display (e.g. nuclei of the thalamus), whereas the structure-label-volume argument contains all CIFTI voxel-based structures you want to include data within (e.g. THALAMUS_LEFT, THALAMUS_RIGHT, etc). See -volume-label-import and -volume-help for format details of label volume files. If you just want the labels in voxels to be the structure names, you may use the same file for both arguments. The structure-label-volume must use some of the label names from this list, all other label names in the structure-label-volume will be ignored:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 1
  - id: volume_label_volume
    type:
      - 'null'
      - File
    doc: label volume file containing the data to be copied
    inputBinding:
      position: 2
      prefix: -volume
  - id: volume_structure_label_volume
    type:
      - 'null'
      - File
    doc: label volume file that defines which voxels to use (give with volume_label_volume)
    inputBinding:
      position: 3
  - id: left_label
    type:
      - 'null'
      - File
    doc: 'label file for left surface: the label file'
    inputBinding:
      position: 4
      prefix: -left-label
  - id: roi_left
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from left surface: the ROI as a metric file (use with -left-label)'
    inputBinding:
      position: 5
      prefix: -roi-left
  - id: right_label
    type:
      - 'null'
      - File
    doc: 'label for left surface: the label file'
    inputBinding:
      position: 6
      prefix: -right-label
  - id: roi_right
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from right surface: the ROI as a metric file (use with -right-label)'
    inputBinding:
      position: 7
      prefix: -roi-right
  - id: cerebellum_label
    type:
      - 'null'
      - File
    doc: 'label for the cerebellum: the label file'
    inputBinding:
      position: 8
      prefix: -cerebellum-label
  - id: roi_cerebellum
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from right surface: the ROI as a metric file (use with -cerebellum-label)'
    inputBinding:
      position: 9
      prefix: -roi-cerebellum
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
