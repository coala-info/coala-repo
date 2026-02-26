cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy_mouse2human_eset
label: iobrpy_mouse2human_eset
doc: "Convert mouse gene symbols to human gene symbols.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: column_of_symbol
    type:
      - 'null'
      - string
    doc: Column name containing gene symbols when not using --is_matrix.
    inputBinding:
      position: 101
      prefix: --column_of_symbol
  - id: input_file
    type: File
    doc: Path to input file (CSV/TSV/TXT, optionally .gz)
    inputBinding:
      position: 101
      prefix: --input
  - id: is_matrix
    type:
      - 'null'
      - boolean
    doc: Treat input as a matrix (rows=genes, cols=samples). If omitted, expects
      a symbol column.
    inputBinding:
      position: 101
      prefix: --is_matrix
  - id: out_sep
    type:
      - 'null'
      - string
    doc: Output separator (',' or '\t'). If omitted, infer by output extension.
    inputBinding:
      position: 101
      prefix: --out_sep
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show a progress bar during saving.
    inputBinding:
      position: 101
      prefix: --progress
  - id: sep
    type:
      - 'null'
      - string
    doc: Input separator (',' or '\t'). If omitted, infer by input extension.
    inputBinding:
      position: 101
      prefix: --sep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Path to save converted matrix (CSV/TSV/TXT, optionally .gz)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
