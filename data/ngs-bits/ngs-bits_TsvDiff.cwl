cwlVersion: v1.2
class: CommandLineTool
baseCommand: TsvDiff
label: ngs-bits_TsvDiff
doc: "Compares TSV files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: comp
    type:
      - 'null'
      - string
    doc: "Comma-separated list of columns to use for comparison (all other columns are ignored)."
    inputBinding:
      position: 1
      prefix: -comp
  - id: debug
    type:
      - 'null'
      - int
    doc: "Debug level (0=none, 1=basic, 2=extended"
    inputBinding:
      position: 2
      prefix: -debug
  - id: diff_abs
    type:
      - 'null'
      - string
    doc: "Comma-separated list of column=difference tuples for defining maximum allowed numeric difference of columns."
    inputBinding:
      position: 3
      prefix: -diff_abs
  - id: in1
    type: File
    doc: "First input TSV file."
    inputBinding:
      position: 4
      prefix: -in1
  - id: in2
    type: File
    doc: "Second input TSV file."
    inputBinding:
      position: 5
      prefix: -in2
  - id: no_error
    type:
      - 'null'
      - boolean
    doc: "Do not exit with error state if differences are detected."
    inputBinding:
      position: 6
      prefix: -no_error
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file with differences. If unset, writes to stdout."
    inputBinding:
      position: 7
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 8
      prefix: --settings
  - id: skip_cols
    type:
      - 'null'
      - string
    doc: "Comma-separated list of colums to skip during line comparison."
    inputBinding:
      position: 9
      prefix: -skip_cols
  - id: skip_comments
    type:
      - 'null'
      - boolean
    doc: "Do not compare comment lines starting with '##'."
    inputBinding:
      position: 10
      prefix: -skip_comments
  - id: skip_comments_matching
    type:
      - 'null'
      - string
    doc: "Comma-separated list of sub-strings for skipping comment lines (case-sensitive matching)."
    inputBinding:
      position: 11
      prefix: -skip_comments_matching
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output file with differences. If unset, writes to stdout."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
successCodes: [0, 1]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
