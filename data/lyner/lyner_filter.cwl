cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_filter
doc: "Filter data according to selected option.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX filter show`.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging (global lyner option -v, written to standard error)"
    inputBinding:
      position: 0
      prefix: -v
  - id: matrix
    type: File
    doc: "Abundance or count matrix in tsv format (first column: feature names; other columns: samples), read with `lyner read`"
    inputBinding:
      position: 2
  - id: sum
    type:
      - 'null'
      - int
    doc: "Drops rows with sum smaller than or equal to given value"
    inputBinding:
      position: 20
      prefix: --sum
  - id: zeros
    type:
      - 'null'
      - int
    doc: "Drop rows with up to the given amount of zeros"
    inputBinding:
      position: 20
      prefix: --zeros
  - id: identical
    type:
      - 'null'
      - boolean
    doc: "Drop rows consisting of only one single value"
    inputBinding:
      position: 20
      prefix: --identical
  - id: negative
    type:
      - 'null'
      - boolean
    doc: "Drop rows with negative entries"
    inputBinding:
      position: 20
      prefix: --negative
  - id: drop_na
    type:
      - 'null'
      - boolean
    doc: "Drop rows with NA/nan/empty entries"
    inputBinding:
      position: 20
      prefix: --drop-na
  - id: drop_duplicates
    type:
      - 'null'
      - boolean
    doc: "Drop duplicate rows"
    inputBinding:
      position: 20
      prefix: --drop-duplicates
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Drop rows whose name starts with one of these comma separated prefixes"
    inputBinding:
      position: 20
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Drop rows whose name ends with one of these comma separated suffixes"
    inputBinding:
      position: 20
      prefix: --suffix
  - id: variance_relative
    type:
      - 'null'
      - float
    doc: "Keep the top n% most variant rows, drop the rest (fraction between 0 and 1)"
    inputBinding:
      position: 20
      prefix: --variance-relative
  - id: variance_absolute
    type:
      - 'null'
      - int
    doc: "Keep the top k most variant rows, drop the rest"
    inputBinding:
      position: 20
      prefix: --variance-absolute
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: filter
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_filter.out
