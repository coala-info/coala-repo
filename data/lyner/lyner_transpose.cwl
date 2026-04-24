cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - transpose
label: lyner_transpose
doc: "Transpose a matrix or a selection of columns from a matrix.\n\nTool homepage:
  https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file (e.g., TSV, CSV)
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter for input and output files.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Indicates if the input matrix has a header row.
    inputBinding:
      position: 102
      prefix: --header
  - id: selection
    type:
      - 'null'
      - string
    doc: Comma-separated list of column names or indices to transpose. If not 
      provided, the entire matrix is transposed.
    inputBinding:
      position: 102
      prefix: --selection
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path for the transposed matrix.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
