cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-palette
label: connectome-workbench_wb_command_cifti-palette
doc: "NOTE: The output file must be a different file than the input file. For scalar maps, by default the palette is changed for every map, specify -column to change only one map. Palette settings not specified will be taken from the first column for scalar maps, and from the existing file palette for other mapping types. The <mode> argument must be one of the following:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti input
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: the mapping mode
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 3
  - id: column
    type:
      - 'null'
      - string
    doc: 'select a single column for scalar maps: the column number or name'
    inputBinding:
      position: 4
      prefix: -column
  - id: pos_percent_pos_min
    type:
      - 'null'
      - float
    doc: the percentile for the least positive data
    inputBinding:
      position: 5
      prefix: -pos-percent
  - id: pos_percent_pos_max
    type:
      - 'null'
      - float
    doc: the percentile for the most positive data (give with pos_percent_pos_min)
    inputBinding:
      position: 6
  - id: neg_percent_neg_min
    type:
      - 'null'
      - float
    doc: the percentile for the least negative data
    inputBinding:
      position: 7
      prefix: -neg-percent
  - id: neg_percent_neg_max
    type:
      - 'null'
      - float
    doc: the percentile for the most negative data (give with neg_percent_neg_min)
    inputBinding:
      position: 8
  - id: pos_user_pos_min_user
    type:
      - 'null'
      - float
    doc: the value for the least positive data
    inputBinding:
      position: 9
      prefix: -pos-user
  - id: pos_user_pos_max_user
    type:
      - 'null'
      - float
    doc: the value for the most positive data (give with pos_user_pos_min_user)
    inputBinding:
      position: 10
  - id: neg_user_neg_min_user
    type:
      - 'null'
      - float
    doc: the value for the least negative data
    inputBinding:
      position: 11
      prefix: -neg-user
  - id: neg_user_neg_max_user
    type:
      - 'null'
      - float
    doc: the value for the most negative data (give with neg_user_neg_min_user)
    inputBinding:
      position: 12
  - id: interpolate
    type:
      - 'null'
      - string
    doc: 'interpolate colors: boolean, whether to interpolate'
    inputBinding:
      position: 13
      prefix: -interpolate
  - id: disp_pos
    type:
      - 'null'
      - string
    doc: 'display positive data: boolean, whether to display'
    inputBinding:
      position: 14
      prefix: -disp-pos
  - id: disp_neg
    type:
      - 'null'
      - string
    doc: 'display positive data: boolean, whether to display'
    inputBinding:
      position: 15
      prefix: -disp-neg
  - id: disp_zero
    type:
      - 'null'
      - string
    doc: 'display data closer to zero than the min cutoff: boolean, whether to display'
    inputBinding:
      position: 16
      prefix: -disp-zero
  - id: palette_name
    type:
      - 'null'
      - string
    doc: 'set the palette used: the name of the palette'
    inputBinding:
      position: 17
      prefix: -palette-name
  - id: thresholding_type
    type:
      - 'null'
      - string
    doc: thresholding setting
    inputBinding:
      position: 18
      prefix: -thresholding
  - id: thresholding_test
    type:
      - 'null'
      - string
    doc: show values inside or outside thresholds (give with thresholding_type)
    inputBinding:
      position: 19
  - id: thresholding_min
    type:
      - 'null'
      - float
    doc: lower threshold (give with thresholding_type)
    inputBinding:
      position: 20
  - id: thresholding_max
    type:
      - 'null'
      - float
    doc: upper threshold (give with thresholding_type)
    inputBinding:
      position: 21
  - id: inversion
    type:
      - 'null'
      - string
    doc: 'specify palette inversion: the type of inversion'
    inputBinding:
      position: 22
      prefix: -inversion
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
