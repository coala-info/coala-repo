cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-math
label: connectome-workbench_wb_command_metric-math
doc: 'This command evaluates <expression> at each surface vertex independently. There
  must be at least one -var option (to get the structure, number of vertices, and
  number of columns from), even if the <name> specified in it isn''t used in <expression>.
  All metrics must have the same number of vertices. Filenames are not valid in <expression>,
  use a variable name and a -var option with matching <name> to specify an input file.
  If the -column option is given to any -var option, only one column is used from
  that file. If -repeat is specified, the file must either have only one column, or
  have the -column option specified. All files that don''t use -repeat must have the
  same number of columns requested to be used. The format of <expression> is as follows:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: var_rec
        type: record
        fields:
          - name: name
            type: string
            doc: the name of the variable, as used in the expression
            inputBinding:
              position: 1
          - name: metric
            type: File
            doc: the metric file to use as this variable
            inputBinding:
              position: 2
          - name: column
            type:
              - 'null'
              - string
            doc: select a single column
            inputBinding:
              position: 3
              prefix: -column
          - name: repeat
            type:
              - 'null'
              - boolean
            doc: reuse a single column for each column of calculation
            inputBinding:
              position: 3
              prefix: -repeat
inputs:
  - id: expression
    type: string
    doc: the expression to evaluate, in quotes
    inputBinding:
      position: 1
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 2
  - id: fixnan
    type:
      - 'null'
      - float
    doc: replace NaN results with a value
    inputBinding:
      position: 3
      prefix: -fixnan
  - id: var
    type:
      - 'null'
      - type: array
        items: var_rec
        inputBinding:
          prefix: -var
    doc: a metric to use as a variable
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
