cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - filter
label: lyner_filter
doc: "Filter data according to selected option.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: drop_duplicates
    type:
      - 'null'
      - boolean
    doc: Drop duplicate rows.
    inputBinding:
      position: 101
      prefix: --drop-duplicates
  - id: drop_na
    type:
      - 'null'
      - boolean
    doc: Drop rows with NA/nan/empty entries.
    inputBinding:
      position: 101
      prefix: --drop-na
  - id: identical
    type:
      - 'null'
      - boolean
    doc: Drop rows consisting of only one single value.
    inputBinding:
      position: 101
      prefix: --identical
  - id: negative
    type:
      - 'null'
      - boolean
    doc: Drop rows with negative entries.
    inputBinding:
      position: 101
      prefix: --negative
  - id: prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: Prefixes to consider
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - type: array
        items: string
    doc: Suffixes to consider
    inputBinding:
      position: 101
      prefix: --suffix
  - id: sum
    type:
      - 'null'
      - int
    doc: Drops rows with sum smaller than or equal to given value.
    inputBinding:
      position: 101
      prefix: --sum
  - id: variance_absolute
    type:
      - 'null'
      - int
    doc: Keep the top k most variant rows, drop the rest.
    inputBinding:
      position: 101
      prefix: --variance-absolute
  - id: variance_relative
    type:
      - 'null'
      - float
    doc: Keep the top n% most variant rows, drop the rest.
    inputBinding:
      position: 101
      prefix: --variance-relative
  - id: zeros
    type:
      - 'null'
      - int
    doc: Drop rows with up to the given amount of zeros.
    inputBinding:
      position: 101
      prefix: --zeros
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_filter.out
