cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-create-dense-scalar
label: connectome-workbench_wb_command_cifti-create-dense-scalar
doc: "All input files must have the same number of columns/subvolumes. Only the specified components will be in the output cifti file. Map names will be taken from one of the input files. At least one component must be specified. See -volume-label-import and -volume-help for format details of label volume files. The structure-label-volume should have some of the label names from this list, all other label names will be ignored:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 1
  - id: volume_volume_data
    type:
      - 'null'
      - File
    doc: volume file containing all voxel data for all volume structures
    inputBinding:
      position: 2
      prefix: -volume
  - id: volume_structure_label_volume
    type:
      - 'null'
      - File
    doc: label volume file containing labels for cifti structures (give with volume_volume_data)
    inputBinding:
      position: 3
  - id: left_metric
    type:
      - 'null'
      - File
    doc: 'metric for left surface: the metric file'
    inputBinding:
      position: 4
      prefix: -left-metric
  - id: roi_left
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from left surface: the ROI as a metric file (use with -left-metric)'
    inputBinding:
      position: 5
      prefix: -roi-left
  - id: right_metric
    type:
      - 'null'
      - File
    doc: 'metric for left surface: the metric file'
    inputBinding:
      position: 6
      prefix: -right-metric
  - id: roi_right
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from right surface: the ROI as a metric file (use with -right-metric)'
    inputBinding:
      position: 7
      prefix: -roi-right
  - id: cerebellum_metric
    type:
      - 'null'
      - File
    doc: 'metric for the cerebellum: the metric file'
    inputBinding:
      position: 8
      prefix: -cerebellum-metric
  - id: roi_cerebellum
    type:
      - 'null'
      - File
    doc: 'roi of vertices to use from right surface: the ROI as a metric file (use with -cerebellum-metric)'
    inputBinding:
      position: 9
      prefix: -roi-cerebellum
  - id: name_file
    type:
      - 'null'
      - File
    doc: 'use a text file to set all map names: text file containing map names, one per line'
    inputBinding:
      position: 10
      prefix: -name-file
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
