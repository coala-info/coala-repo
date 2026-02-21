cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-append
label: tsv-utils_tsv-append
doc: "Concatenate TSV files, maintaining the header of the first file and optionally
  tracking the source of each row. (Note: The provided help text contained system
  error logs rather than tool usage; arguments list is based on standard tsv-append
  functionality).\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input TSV files to be concatenated.
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: Use the header from the first file and skip headers in subsequent files.
    inputBinding:
      position: 102
      prefix: --header
  - id: source_header
    type:
      - 'null'
      - string
    doc: The header string to use for the source tracking column.
    inputBinding:
      position: 102
      prefix: --source-header
  - id: track
    type:
      - 'null'
      - boolean
    doc: Add a column to the output indicating the source file for each row.
    inputBinding:
      position: 102
      prefix: --track
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-append.out
