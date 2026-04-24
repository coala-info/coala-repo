cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_sort
label: xsv_sort
doc: "Sorts CSV data lexicographically.\n\nTool homepage: https://github.com/BurntSushi/xsv"
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
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. Namely, it 
      will be sorted with the rest of the rows. Otherwise, the first row will 
      always appear as the header row in the output.
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: select_columns
    type:
      - 'null'
      - string
    doc: Select a subset of columns to sort. See 'xsv select --help' for the 
      format details.
    inputBinding:
      position: 102
      prefix: --select
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
