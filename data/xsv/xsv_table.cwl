cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_table
label: xsv_table
doc: "Outputs CSV data as a table with columns in alignment.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: condense
    type:
      - 'null'
      - int
    doc: Limits the length of each field to the value specified. If the field is
      UTF-8 encoded, then <arg> refers to the number of code points. Otherwise, 
      it refers to the number of bytes.
    inputBinding:
      position: 102
      prefix: --condense
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: pad
    type:
      - 'null'
      - int
    doc: The minimum number of spaces between each column.
    inputBinding:
      position: 102
      prefix: --pad
  - id: width
    type:
      - 'null'
      - int
    doc: The minimum width of each column.
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
