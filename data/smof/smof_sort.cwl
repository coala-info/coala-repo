cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_sort
label: smof_sort
doc: "Sorts the entries in a fasta file. By default, it sorts by the header strings.\n\
  `sort` reads the entire file into memory, so should not be used for extremely\n\
  large files.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: field_separator
    type:
      - 'null'
      - string
    doc: The field separator
    inputBinding:
      position: 102
      prefix: --field-separator
  - id: key
    type:
      - 'null'
      - string
    doc: Key to sort on (column number or tag)
    inputBinding:
      position: 102
      prefix: --key
  - id: length_sort
    type:
      - 'null'
      - boolean
    doc: sort by sequence length
    inputBinding:
      position: 102
      prefix: --length-sort
  - id: numeric_sort
    type:
      - 'null'
      - boolean
    doc: numeric sort
    inputBinding:
      position: 102
      prefix: --numeric-sort
  - id: pair_separator
    type:
      - 'null'
      - string
    doc: The separator between a tag and value
    inputBinding:
      position: 102
      prefix: --pair-separator
  - id: random_sort
    type:
      - 'null'
      - boolean
    doc: randomly sort sequences
    inputBinding:
      position: 102
      prefix: --random-sort
  - id: regex
    type:
      - 'null'
      - string
    doc: sort by single regex capture
    inputBinding:
      position: 102
      prefix: --regex
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse sort
    inputBinding:
      position: 102
      prefix: --reverse
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sort.out
