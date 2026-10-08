cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-palette
label: connectome-workbench_wb_command_metric-palette
doc: 'The original metric file is overwritten with the modified version. By default,
  all columns of the metric file are adjusted to the new settings, use the -column
  option to change only one column. Mapping settings not specified in options will
  be taken from the first column. The <mode> argument must be one of the following:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: pos_percent_rec
        type: record
        fields:
          - name: pos_min
            type: float
            doc: the percentile for the least positive data
            inputBinding:
              position: 1
          - name: pos_max
            type: float
            doc: the percentile for the most positive data
            inputBinding:
              position: 2
      - name: neg_percent_rec
        type: record
        fields:
          - name: neg_min
            type: float
            doc: the percentile for the least negative data
            inputBinding:
              position: 1
          - name: neg_max
            type: float
            doc: the percentile for the most negative data
            inputBinding:
              position: 2
      - name: pos_user_rec
        type: record
        fields:
          - name: pos_min_user
            type: float
            doc: the value for the least positive data
            inputBinding:
              position: 1
          - name: pos_max_user
            type: float
            doc: the value for the most positive data
            inputBinding:
              position: 2
      - name: neg_user_rec
        type: record
        fields:
          - name: neg_min_user
            type: float
            doc: the value for the least negative data
            inputBinding:
              position: 1
          - name: neg_max_user
            type: float
            doc: the value for the most negative data
            inputBinding:
              position: 2
      - name: thresholding_rec
        type: record
        fields:
          - name: type
            type: string
            doc: thresholding setting
            inputBinding:
              position: 1
          - name: test
            type: string
            doc: show values inside or outside thresholds
            inputBinding:
              position: 2
          - name: min
            type: float
            doc: lower threshold
            inputBinding:
              position: 3
          - name: max
            type: float
            doc: upper threshold
            inputBinding:
              position: 4
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.metric)
        writable: true
inputs:
  - id: metric
    type: File
    doc: the metric to modify
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: the mapping mode
    inputBinding:
      position: 2
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column
    inputBinding:
      position: 3
      prefix: -column
  - id: pos_percent
    type:
      - 'null'
      - pos_percent_rec
    doc: percentage min/max for positive data coloring
    inputBinding:
      position: 3
      prefix: -pos-percent
  - id: neg_percent
    type:
      - 'null'
      - neg_percent_rec
    doc: percentage min/max for negative data coloring
    inputBinding:
      position: 3
      prefix: -neg-percent
  - id: pos_user
    type:
      - 'null'
      - pos_user_rec
    doc: user min/max values for positive data coloring
    inputBinding:
      position: 3
      prefix: -pos-user
  - id: neg_user
    type:
      - 'null'
      - neg_user_rec
    doc: user min/max values for negative data coloring
    inputBinding:
      position: 3
      prefix: -neg-user
  - id: interpolate
    type:
      - 'null'
      - string
    doc: interpolate colors
    inputBinding:
      position: 3
      prefix: -interpolate
  - id: disp_pos
    type:
      - 'null'
      - string
    doc: display positive data
    inputBinding:
      position: 3
      prefix: -disp-pos
  - id: disp_neg
    type:
      - 'null'
      - string
    doc: display positive data
    inputBinding:
      position: 3
      prefix: -disp-neg
  - id: disp_zero
    type:
      - 'null'
      - string
    doc: display data closer to zero than the min cutoff
    inputBinding:
      position: 3
      prefix: -disp-zero
  - id: palette_name
    type:
      - 'null'
      - string
    doc: set the palette used
    inputBinding:
      position: 3
      prefix: -palette-name
  - id: thresholding
    type:
      - 'null'
      - thresholding_rec
    doc: set the thresholding
    inputBinding:
      position: 3
      prefix: -thresholding
  - id: inversion
    type:
      - 'null'
      - string
    doc: specify palette inversion
    inputBinding:
      position: 3
      prefix: -inversion
outputs:
  - id: metric_modified
    type: File
    doc: the input file, modified in place
    outputBinding:
      glob: $(inputs.metric.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
