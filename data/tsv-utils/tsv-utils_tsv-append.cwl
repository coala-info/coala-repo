cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-append
label: tsv-utils_tsv-append
doc: "Concatenate TSV files, writing the header of the first file only, with optional source tracking.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input TSV files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: -H
  - id: track_source
    type:
      - 'null'
      - boolean
    doc: "Track the source file. Adds a column with the source name."
    inputBinding:
      position: 101
      prefix: -t
  - id: source_header
    type:
      - 'null'
      - string
    doc: "Use STR as the header for the source column. Implies header and track-source. Default: file"
    inputBinding:
      position: 101
      prefix: -s
  - id: file_sources
    type:
      - 'null'
      - type: array
        items: source_file
        inputBinding:
          prefix: -f
          valueFrom: "$(self.label)=$(self.file.path)"
    doc: "Read file FILE, using LABEL as the source value. Implies track-source."
    inputBinding:
      position: 101
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: -d
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: "Immediately output every line."
    inputBinding:
      position: 101
      prefix: --line-buffered
outputs:
  - id: tsv
    type: stdout
    doc: "Concatenated TSV data"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: source_file
        type: record
        fields:
          - name: label
            type: string
          - name: file
            type: File
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-append_output.tsv
