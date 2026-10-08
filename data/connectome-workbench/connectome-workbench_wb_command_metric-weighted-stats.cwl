cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-weighted-stats
label: connectome-workbench_wb_command_metric-weighted-stats
doc: 'For each column of the input, a single number is printed, resulting from the
  specified operation. You must specify exactly one of -area-surface or -weight-metric.
  Use -column to only give output for a single column. Use -roi to consider only the
  data within a region. Exactly one of -mean, -stdev, -percentile or -sum must be
  specified.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: roi_rec
        type: record
        fields:
          - name: roi_metric
            type: File
            doc: the roi, as a metric file
            inputBinding:
              position: 1
          - name: match_maps
            type:
              - 'null'
              - boolean
            doc: each column of input uses the corresponding column from the roi file
            inputBinding:
              position: 2
              prefix: -match-maps
      - name: stdev_rec
        type: record
        fields:
          - name: sample
            type:
              - 'null'
              - boolean
            doc: estimate population stdev from the sample
            inputBinding:
              position: 1
              prefix: -sample
inputs:
  - id: metric_in
    type: File
    doc: the input metric
    inputBinding:
      position: 1
  - id: area_surface
    type:
      - 'null'
      - File
    doc: use vertex areas as weights
    inputBinding:
      position: 2
      prefix: -area-surface
  - id: weight_metric
    type:
      - 'null'
      - File
    doc: use weights from a metric file
    inputBinding:
      position: 2
      prefix: -weight-metric
  - id: column
    type:
      - 'null'
      - string
    doc: only display output for one column
    inputBinding:
      position: 2
      prefix: -column
  - id: roi
    type:
      - 'null'
      - roi_rec
    doc: only consider data inside an roi
    inputBinding:
      position: 2
      prefix: -roi
  - id: mean
    type:
      - 'null'
      - boolean
    doc: compute weighted mean
    inputBinding:
      position: 2
      prefix: -mean
  - id: stdev
    type:
      - 'null'
      - stdev_rec
    doc: compute weighted standard deviation
    inputBinding:
      position: 2
      prefix: -stdev
  - id: percentile
    type:
      - 'null'
      - float
    doc: compute weighted percentile
    inputBinding:
      position: 2
      prefix: -percentile
  - id: sum
    type:
      - 'null'
      - boolean
    doc: compute weighted sum
    inputBinding:
      position: 2
      prefix: -sum
  - id: show_map_name
    type:
      - 'null'
      - boolean
    doc: print map index and name before each output
    inputBinding:
      position: 2
      prefix: -show-map-name
  - id: output_name
    type: string
    default: metric-weighted-stats.txt
    doc: name of the file that receives the printed output
outputs:
  - id: output
    type: File
    doc: the printed output
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
