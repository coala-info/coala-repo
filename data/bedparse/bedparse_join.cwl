cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse_join
label: bedparse_join
doc: "Adds the content of an annotation file to a BED file as extra columns. The two
  files are joined by matching the BED Name field (column 4) with a user-specified
  field of the annotation file.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: Path to the annotation file.
    inputBinding:
      position: 102
      prefix: --annotation
  - id: column
    type:
      - 'null'
      - int
    doc: Column of the annotation file (1-based, default=1).
    inputBinding:
      position: 102
      prefix: --column
  - id: empty
    type:
      - 'null'
      - string
    doc: String to append to empty records (default ').
    inputBinding:
      position: 102
      prefix: --empty
  - id: no_unmatched
    type:
      - 'null'
      - boolean
    doc: Do not print unmatched lines.
    inputBinding:
      position: 102
      prefix: --noUnmatched
  - id: separator
    type:
      - 'null'
      - string
    doc: Field separator for the annotation file (default tab)
    inputBinding:
      position: 102
      prefix: --separator
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_join.out
