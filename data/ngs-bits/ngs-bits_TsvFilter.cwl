cwlVersion: v1.2
class: CommandLineTool
baseCommand: TsvFilter
label: ngs-bits_TsvFilter
doc: "Filters the rows of a TSV file according to the value of a specific column.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: filter
    type: string
    doc: "Filter string with column name, operation and value,e.g. 'depth > 17'. Valid operations are '>','>=','=','<=','<','is','contains'."
    inputBinding:
      position: 1
      prefix: -filter
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input TSV file. If unset, reads from STDIN."
    inputBinding:
      position: 2
      prefix: -in
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: "If set, column name is interpreted as a 1-based column number."
    inputBinding:
      position: 3
      prefix: -numeric
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output TSV file. If unset, writes to STDOUT."
    inputBinding:
      position: 4
      prefix: -out
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 5
      prefix: --settings
  - id: v
    type:
      - 'null'
      - boolean
    doc: "Invert filter."
    inputBinding:
      position: 6
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output TSV file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
