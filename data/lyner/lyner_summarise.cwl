cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - summarise
label: lyner_summarise
doc: "Summarise a lyner matrix\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input lyner matrix file
    inputBinding:
      position: 1
  - id: agg_funcs
    type:
      - 'null'
      - type: array
        items: string
    doc: Aggregation functions to apply (e.g., 'sum', 'mean', 'count')
    inputBinding:
      position: 102
      prefix: --agg-funcs
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Columns to aggregate
    inputBinding:
      position: 102
      prefix: --columns
  - id: group_by
    type:
      - 'null'
      - type: array
        items: string
    doc: Column(s) to group by
    inputBinding:
      position: 102
      prefix: --group-by
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for summarised matrix
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
