cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-average-roi-correlation
label: connectome-workbench_wb_command_cifti-average-roi-correlation
doc: "Averages rows for each map of the ROI(s), takes the correlation of each ROI average to the rest of the rows in the same file, then averages the results across all files. ROIs are always treated as weighting functions, including negative values. For efficiency, ensure that everything that is not intended to be used is zero in the ROI map. If -cifti-roi is specified, -left-roi, -right-roi, -cerebellum-roi, and -vol-roi must not be specified. If multiple non-cifti ROI files are specified, they must have the same number of columns.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 1
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: 'cifti file containing combined weights: the roi cifti file'
    inputBinding:
      position: 2
      prefix: -cifti-roi
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: cache the roi in memory so that it isn't re-read for each input cifti (use with -cifti-roi)
    inputBinding:
      position: 3
      prefix: -in-memory
  - id: left_roi
    type:
      - 'null'
      - File
    doc: 'weights to use for left hempsphere: the left roi as a metric file'
    inputBinding:
      position: 4
      prefix: -left-roi
  - id: right_roi
    type:
      - 'null'
      - File
    doc: 'weights to use for right hempsphere: the right roi as a metric file'
    inputBinding:
      position: 5
      prefix: -right-roi
  - id: cerebellum_roi
    type:
      - 'null'
      - File
    doc: 'weights to use for cerebellum surface: the cerebellum roi as a metric file'
    inputBinding:
      position: 6
      prefix: -cerebellum-roi
  - id: vol_roi
    type:
      - 'null'
      - File
    doc: 'voxel weights to use: the roi volume file'
    inputBinding:
      position: 7
      prefix: -vol-roi
  - id: left_area_surf
    type:
      - 'null'
      - File
    doc: 'specify the left surface for vertex area correction: the left surface file'
    inputBinding:
      position: 8
      prefix: -left-area-surf
  - id: right_area_surf
    type:
      - 'null'
      - File
    doc: 'specify the right surface for vertex area correction: the right surface file'
    inputBinding:
      position: 9
      prefix: -right-area-surf
  - id: cerebellum_area_surf
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface for vertex area correction: the cerebellum surface file'
    inputBinding:
      position: 10
      prefix: -cerebellum-area-surf
  - id: cifti
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -cifti
    doc: 'specify an input cifti file: a cifti file to average across (repeatable)'
    inputBinding:
      position: 11
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
