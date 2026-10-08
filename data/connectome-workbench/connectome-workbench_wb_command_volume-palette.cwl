cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-palette
label: connectome-workbench_wb_command_volume-palette
doc: "The original volume file is overwritten with the modified version. By default, all columns of the volume file are adjusted to the new settings, use the -subvolume option to change only one subvolume. Mapping settings not specified in options will be taken from the first subvolume.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.volume)
        writable: true
inputs:
  - id: volume
    type: File
    doc: "the volume file to modify"
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: "the mapping mode: MODE_AUTO_SCALE, MODE_AUTO_SCALE_ABSOLUTE_PERCENTAGE, MODE_AUTO_SCALE_PERCENTAGE or MODE_USER_SCALE"
    inputBinding:
      position: 2
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume: the subvolume number or name"
    inputBinding:
      position: 3
      prefix: -subvolume
  - id: pos_percent_min
    type:
      - 'null'
      - float
    doc: "the percentile for the least positive data (-pos-percent argument 1 of 2)"
    inputBinding:
      position: 4
      prefix: -pos-percent
  - id: pos_percent_max
    type:
      - 'null'
      - float
    doc: "the percentile for the most positive data (-pos-percent argument 2 of 2)"
    inputBinding:
      position: 5
  - id: neg_percent_min
    type:
      - 'null'
      - float
    doc: "the percentile for the least negative data (-neg-percent argument 1 of 2)"
    inputBinding:
      position: 6
      prefix: -neg-percent
  - id: neg_percent_max
    type:
      - 'null'
      - float
    doc: "the percentile for the most negative data (-neg-percent argument 2 of 2)"
    inputBinding:
      position: 7
  - id: pos_user_min
    type:
      - 'null'
      - float
    doc: "the value for the least positive data (-pos-user argument 1 of 2)"
    inputBinding:
      position: 8
      prefix: -pos-user
  - id: pos_user_max
    type:
      - 'null'
      - float
    doc: "the value for the most positive data (-pos-user argument 2 of 2)"
    inputBinding:
      position: 9
  - id: neg_user_min
    type:
      - 'null'
      - float
    doc: "the value for the least negative data (-neg-user argument 1 of 2)"
    inputBinding:
      position: 10
      prefix: -neg-user
  - id: neg_user_max
    type:
      - 'null'
      - float
    doc: "the value for the most negative data (-neg-user argument 2 of 2)"
    inputBinding:
      position: 11
  - id: interpolate
    type:
      - 'null'
      - string
    doc: "interpolate colors: boolean (true or false), whether to interpolate"
    inputBinding:
      position: 12
      prefix: -interpolate
  - id: disp_pos
    type:
      - 'null'
      - string
    doc: "display positive data: boolean (true or false), whether to display"
    inputBinding:
      position: 13
      prefix: -disp-pos
  - id: disp_neg
    type:
      - 'null'
      - string
    doc: "display negative data: boolean (true or false), whether to display"
    inputBinding:
      position: 14
      prefix: -disp-neg
  - id: disp_zero
    type:
      - 'null'
      - string
    doc: "display data closer to zero than the min cutoff: boolean (true or false), whether to display"
    inputBinding:
      position: 15
      prefix: -disp-zero
  - id: palette_name
    type:
      - 'null'
      - string
    doc: "set the palette used: the name of the palette, e.g. ROY-BIG-BL, videen_style, Gray_Interp_Positive, PSYCH, FSL, magma, JET256"
    inputBinding:
      position: 16
      prefix: -palette-name
  - id: thresholding_type
    type:
      - 'null'
      - string
    doc: "THRESHOLD_TYPE_OFF, THRESHOLD_TYPE_NORMAL or THRESHOLD_TYPE_FILE (-thresholding argument 1 of 4)"
    inputBinding:
      position: 17
      prefix: -thresholding
  - id: thresholding_test
    type:
      - 'null'
      - string
    doc: "THRESHOLD_TEST_SHOW_OUTSIDE or THRESHOLD_TEST_SHOW_INSIDE (-thresholding argument 2 of 4)"
    inputBinding:
      position: 18
  - id: thresholding_min
    type:
      - 'null'
      - float
    doc: "lower threshold (-thresholding argument 3 of 4)"
    inputBinding:
      position: 19
  - id: thresholding_max
    type:
      - 'null'
      - float
    doc: "upper threshold (-thresholding argument 4 of 4)"
    inputBinding:
      position: 20
  - id: inversion
    type:
      - 'null'
      - string
    doc: "specify palette inversion: the type of inversion: OFF, POSITIVE_WITH_NEGATIVE or POSITIVE_NEGATIVE_SEPARATE"
    inputBinding:
      position: 21
      prefix: -inversion
outputs:
  - id: output_volume
    type: File
    doc: "the input volume with the new palette (modified copy)"
    outputBinding:
      glob: $(inputs.volume.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
