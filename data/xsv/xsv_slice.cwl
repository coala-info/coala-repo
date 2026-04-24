cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_slice
label: xsv_slice
doc: "Returns the rows in the range specified (starting at 0, half-open interval).
  The range does not include headers.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: end
    type:
      - 'null'
      - int
    doc: The index of the record to slice to.
    inputBinding:
      position: 102
      prefix: --end
  - id: index
    type:
      - 'null'
      - int
    doc: Slice a single record (shortcut for -s N -l 1).
    inputBinding:
      position: 102
      prefix: --index
  - id: len
    type:
      - 'null'
      - int
    doc: The length of the slice (can be used instead of --end).
    inputBinding:
      position: 102
      prefix: --len
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. Otherwise, 
      the first row will always appear in the output as the header row.
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: start
    type:
      - 'null'
      - int
    doc: The index of the record to slice from.
    inputBinding:
      position: 102
      prefix: --start
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
