cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-smoothing
label: connectome-workbench_wb_command_metric-smoothing
doc: 'Smooth a metric file on a surface. By default, smooths all input columns on
  the entire surface, specify -column to use only one input column, and -roi to smooth
  only where the roi metric is greater than 0, outputting zeros elsewhere.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: roi_rec
        type: record
        fields:
          - name: roi_metric
            type: File
            doc: the roi to smooth within, as a metric
            inputBinding:
              position: 1
          - name: match_columns
            type:
              - 'null'
              - boolean
            doc: for each input column, use the corresponding column from the roi
            inputBinding:
              position: 2
              prefix: -match-columns
inputs:
  - id: surface
    type: File
    doc: the surface to smooth on
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the metric to smooth
    inputBinding:
      position: 2
  - id: smoothing_kernel
    type: float
    doc: the sigma for the gaussian kernel function, in mm
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 4
  - id: roi
    type:
      - 'null'
      - roi_rec
    doc: select a region of interest to smooth
    inputBinding:
      position: 5
      prefix: -roi
  - id: fix_zeros
    type:
      - 'null'
      - boolean
    doc: treat zero values as not being data
    inputBinding:
      position: 5
      prefix: -fix-zeros
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to smooth
    inputBinding:
      position: 5
      prefix: -column
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 5
      prefix: -corrected-areas
  - id: method
    type:
      - 'null'
      - string
    doc: select smoothing method, default GEO_GAUSS_AREA
    inputBinding:
      position: 5
      prefix: -method
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
