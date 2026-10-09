cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_transform
doc: "Apply a transformation to the current selection.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX transform show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: func
    type:
      - 'null'
      - string
    doc: "Transformation: log2, log10, log, exp, log1p, expm1 or transpose (default log2)"
    inputBinding:
      position: 20
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: transform
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_transform.out
