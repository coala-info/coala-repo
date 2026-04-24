cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - sort
label: lyner_sort
doc: "Sorts the matrix by columns.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_file
    type: File
    doc: Input file path
    inputBinding:
      position: 1
  - id: ascending
    type:
      - 'null'
      - boolean
    doc: Sort in ascending order. If not specified, descending order is used.
    inputBinding:
      position: 102
      prefix: --ascending
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: Sort the matrix in place. If not specified, a new matrix is returned.
    inputBinding:
      position: 102
      prefix: --inplace
  - id: sort_by
    type:
      - 'null'
      - type: array
        items: string
    doc: List of columns to sort by. If not specified, all columns are used.
    inputBinding:
      position: 102
      prefix: --sort-by
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
