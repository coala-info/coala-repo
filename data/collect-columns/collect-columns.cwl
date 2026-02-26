cwlVersion: v1.2
class: CommandLineTool
baseCommand: collect-columns
label: collect-columns
doc: "Collects specific columns from input files.\n\nTool homepage: https://github.com/biowdl/collect-columns"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input files to process.
    inputBinding:
      position: 1
  - id: columns
    type: string
    doc: Comma-separated list of column names or indices to collect.
    inputBinding:
      position: 102
      prefix: --columns
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter used in the input files. Defaults to comma.
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: Indicates that the input files have a header row.
    inputBinding:
      position: 102
      prefix: --header
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Indicates that the input files do not have a header row.
    inputBinding:
      position: 102
      prefix: --no-header
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file. If not specified, output will be printed to 
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collect-columns:1.0.0--py_0
