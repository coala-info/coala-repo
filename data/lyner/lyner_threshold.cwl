cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_threshold
doc: "Set |data| < value to 0, data >= value to 1, -data >= value to -1.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX threshold show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: value
    type: float
    doc: "Threshold value"
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
    valueFrom: threshold
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_threshold.out
