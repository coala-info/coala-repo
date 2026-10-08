cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-merge
label: connectome-workbench_wb_command_metric-merge
doc: 'Takes one or more metric files and constructs a new metric file by concatenating
  columns from them. The input metric files must have the same number of vertices
  and same structure.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: metric_column_up_to_rec
        type: record
        fields:
          - name: last_column
            type: string
            doc: the number or name of the last column to include
            inputBinding:
              position: 1
          - name: reverse
            type:
              - 'null'
              - boolean
            doc: use the range in reverse order
            inputBinding:
              position: 2
              prefix: -reverse
      - name: metric_column_rec
        type: record
        fields:
          - name: column
            type: string
            doc: the column number or name
            inputBinding:
              position: 1
          - name: up_to
            type:
              - 'null'
              - metric_column_up_to_rec
            doc: use an inclusive range of columns
            inputBinding:
              position: 2
              prefix: -up-to
      - name: metric_rec
        type: record
        fields:
          - name: metric_in
            type: File
            doc: a metric file to use columns from
            inputBinding:
              position: 1
          - name: column
            type:
              - 'null'
              - type: array
                items: metric_column_rec
                inputBinding:
                  prefix: -column
            doc: select a single column to use
            inputBinding:
              position: 2
inputs:
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 1
  - id: metric
    type:
      - 'null'
      - type: array
        items: metric_rec
        inputBinding:
          prefix: -metric
    doc: specify an input metric
    inputBinding:
      position: 2
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
