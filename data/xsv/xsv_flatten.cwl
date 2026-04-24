cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_flatten
label: xsv_flatten
doc: "Prints flattened records such that fields are labeled separated by a new line.
  This mode is particularly useful for viewing one record at a time. Each record is
  separated by a special '#' character (on a line by itself), which can be changed
  with the --separator flag. There is also a condensed view (-c or --condense) that
  will shorten the contents of each field to provide a summary view.\n\nTool homepage:
  https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input file
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
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. When set, 
      the name of each field will be its index.
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: separator
    type:
      - 'null'
      - string
    doc: A string of characters to write after each record. When non-empty, a 
      new line is automatically appended to the separator.
    inputBinding:
      position: 102
      prefix: --separator
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
stdout: xsv_flatten.out
