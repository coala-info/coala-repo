cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-regression
label: connectome-workbench_wb_command_metric-regression
doc: 'For each regressor, its mean across the surface is subtracted from its data.
  Each input map is then regressed against these, and a constant term. The resulting
  regressed slopes of all regressors specified with -remove are multiplied with their
  respective regressor maps, and these are subtracted from the input map.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: remove_rec
        type: record
        fields:
          - name: metric
            type: File
            doc: the metric file to use
            inputBinding:
              position: 1
          - name: remove_column
            type:
              - 'null'
              - string
            doc: select a column to use, rather than all
            inputBinding:
              position: 2
              prefix: -remove-column
      - name: keep_rec
        type: record
        fields:
          - name: metric
            type: File
            doc: the metric file to use
            inputBinding:
              position: 1
          - name: keep_column
            type:
              - 'null'
              - string
            doc: select a column to use, rather than all
            inputBinding:
              position: 2
              prefix: -keep-column
inputs:
  - id: metric_in
    type: File
    doc: the metric to regress from
    inputBinding:
      position: 1
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 2
  - id: roi
    type:
      - 'null'
      - File
    doc: only regress inside an roi
    inputBinding:
      position: 3
      prefix: -roi
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to regress from
    inputBinding:
      position: 3
      prefix: -column
  - id: remove
    type:
      - 'null'
      - type: array
        items: remove_rec
        inputBinding:
          prefix: -remove
    doc: specify a metric to regress out
    inputBinding:
      position: 3
  - id: keep
    type:
      - 'null'
      - type: array
        items: keep_rec
        inputBinding:
          prefix: -keep
    doc: specify a metric to include in regression, but not remove
    inputBinding:
      position: 3
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
