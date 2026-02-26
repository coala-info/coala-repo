cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_cat
label: xsv_cat
doc: "Concatenates CSV data by column or by row.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: mode
    type: string
    doc: "The mode of concatenation: 'rows' or 'columns'."
    inputBinding:
      position: 1
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input CSV files. If none are given, stdin is used.
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    default: ','
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will NOT be interpreted as column names. Note 
      that this has no effect when concatenating columns.
    inputBinding:
      position: 103
      prefix: --no-headers
  - id: pad
    type:
      - 'null'
      - boolean
    doc: When concatenating columns, this flag will cause all records to appear.
      It will pad each row if other CSV data isn't long enough.
    inputBinding:
      position: 103
      prefix: --pad
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
