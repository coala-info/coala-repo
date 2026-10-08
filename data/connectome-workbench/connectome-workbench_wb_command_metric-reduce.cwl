cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-reduce
label: connectome-workbench_wb_command_metric-reduce
doc: 'For each surface vertex, takes the data across columns as a vector, and performs
  the specified reduction on it, putting the result into the single output column
  at that vertex. The reduction operators are as follows:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: exclude_outliers_rec
        type: record
        fields:
          - name: sigma_below
            type: float
            doc: number of standard deviations below the mean to include
            inputBinding:
              position: 1
          - name: sigma_above
            type: float
            doc: number of standard deviations above the mean to include
            inputBinding:
              position: 2
inputs:
  - id: metric_in
    type: File
    doc: the metric to reduce
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: the reduction operator to use
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: exclude_outliers
    type:
      - 'null'
      - exclude_outliers_rec
    doc: exclude non-numeric values and outliers by standard deviation
    inputBinding:
      position: 4
      prefix: -exclude-outliers
  - id: only_numeric
    type:
      - 'null'
      - boolean
    doc: exclude non-numeric values
    inputBinding:
      position: 4
      prefix: -only-numeric
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
