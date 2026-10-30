cwlVersion: v1.2
class: CommandLineTool
baseCommand: TsvMerge
label: ngs-bits_TsvMerge
doc: "Merges TSV file based on a list of columns.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: cols
    type: string
    doc: "Comma-separated list of column names used as key for merging."
    inputBinding:
      position: 1
      prefix: -cols
  - id: input_file
    type: File[]
    doc: "Input TSV files that are merged. If only one file is given, each line in this file is interpreted as an input file path."
    inputBinding:
      position: 2
      prefix: -in
  - id: mv
    type:
      - 'null'
      - string
    doc: "Missing value, i.e. value that is inserted when key is missing in a file."
    inputBinding:
      position: 3
      prefix: -mv
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: "If set, column names are interpreted as 1-based column numbers."
    inputBinding:
      position: 4
      prefix: -numeric
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file. If unset, writes to STDOUT."
    inputBinding:
      position: 5
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 6
      prefix: --settings
  - id: simple
    type:
      - 'null'
      - boolean
    doc: "Fast and memory-efficient mode for merging files that are ordered in the same way and have no missing lines."
    inputBinding:
      position: 7
      prefix: -simple
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
