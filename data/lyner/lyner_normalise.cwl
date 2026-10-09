cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_normalise
doc: "Normalize data using one of the following methods: quantile, deseq, identity, scale, unit, tanh.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX normalise show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: axis
    type:
      - 'null'
      - int
    doc: "Axis: -1 (all values), 0 or 1 (default 0)"
    inputBinding:
      position: 20
      prefix: --axis
  - id: method
    type:
      - 'null'
      - string
    doc: "Normalisation method: quantile, deseq, identity, scale, unit or tanh (default quantile)"
    inputBinding:
      position: 21
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: normalise
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_normalise.out
