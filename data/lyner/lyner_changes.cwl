cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_changes
doc: "Calculate differences between sample groups.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX estimate changes show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: design_file
    type: File
    doc: "Experiment design (tsv with columns Sample, Class) with two classes, passed to `lyner design` before `estimate`"
    inputBinding:
      position: 3
      prefix: design
  - id: estimate_distribution
    type:
      - 'null'
      - string
    doc: "Distribution fitted by the preceding `estimate` step (-d). Default is t"
    inputBinding:
      position: 5
      prefix: --distribution
  - id: mode
    type:
      - 'null'
      - string
    doc: "likelihood or cdf (default likelihood)"
    inputBinding:
      position: 20
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 4
    valueFrom: estimate
  - position: 10
    valueFrom: changes
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_changes.out
