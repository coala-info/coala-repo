cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_read
doc: "Read abundance/count matrix from `MATRIX` (tsv format).\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
outputs:
  - id: stdout
    type: stdout
    doc: "Matrix as read by lyner (tsv, sorted by feature name; non-numeric columns dropped)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_read.out
