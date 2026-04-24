cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-filter
label: tsv-utils_tsv-filter
doc: "A tool for filtering TSV files based on field content using various operators
  (equality, numeric comparison, regular expressions, etc.).\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input TSV files. If not specified, stdin is used.
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Field delimiter character.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: equals
    type:
      - 'null'
      - string
    doc: 'Filter based on string equality (format: field:string).'
    inputBinding:
      position: 102
      prefix: --equals
  - id: header
    type:
      - 'null'
      - boolean
    doc: Treat the first line of each file as a header.
    inputBinding:
      position: 102
      prefix: --header
  - id: is_empty
    type:
      - 'null'
      - string
    doc: 'Filter for empty fields (format: field).'
    inputBinding:
      position: 102
      prefix: --empty
  - id: is_not_empty
    type:
      - 'null'
      - string
    doc: 'Filter for non-empty fields (format: field).'
    inputBinding:
      position: 102
      prefix: --not-empty
  - id: numeric_ge
    type:
      - 'null'
      - string
    doc: 'Filter based on numeric greater-than-or-equal (format: field:num).'
    inputBinding:
      position: 102
      prefix: --ge
  - id: numeric_gt
    type:
      - 'null'
      - string
    doc: 'Filter based on numeric greater-than (format: field:num).'
    inputBinding:
      position: 102
      prefix: --gt
  - id: numeric_le
    type:
      - 'null'
      - string
    doc: 'Filter based on numeric less-than-or-equal (format: field:num).'
    inputBinding:
      position: 102
      prefix: --le
  - id: numeric_lt
    type:
      - 'null'
      - string
    doc: 'Filter based on numeric less-than (format: field:num).'
    inputBinding:
      position: 102
      prefix: --lt
  - id: regex
    type:
      - 'null'
      - string
    doc: 'Filter based on a regular expression (format: field:regex).'
    inputBinding:
      position: 102
      prefix: --regex
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write output to a file instead of stdout.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
