cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - sort
label: smof_sort
doc: "Sort the entries in a FASTA file (by header by default).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: regex
    type:
      - 'null'
      - string
    doc: "Sort by single regex capture"
    inputBinding:
      position: 100
      prefix: --regex
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Reverse sort"
    inputBinding:
      position: 101
      prefix: --reverse
  - id: numeric_sort
    type:
      - 'null'
      - boolean
    doc: "Numeric sort"
    inputBinding:
      position: 102
      prefix: --numeric-sort
  - id: length_sort
    type:
      - 'null'
      - boolean
    doc: "Sort by sequence length"
    inputBinding:
      position: 103
      prefix: --length-sort
  - id: random_sort
    type:
      - 'null'
      - boolean
    doc: "Randomly sort sequences"
    inputBinding:
      position: 104
      prefix: --random-sort
  - id: key
    type:
      - 'null'
      - string
    doc: "Key to sort on (column number or tag)"
    inputBinding:
      position: 105
      prefix: --key
  - id: field_separator
    type:
      - 'null'
      - string
    doc: "The field separator (default: '|')"
    inputBinding:
      position: 106
      prefix: --field-separator
  - id: pair_separator
    type:
      - 'null'
      - string
    doc: "The separator between a tag and value (default: '=')"
    inputBinding:
      position: 107
      prefix: --pair-separator
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sort.out
