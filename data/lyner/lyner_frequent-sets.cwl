cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_frequent-sets
doc: "Calculate frequent sets using the apriori algorithm. Assumes one-hot encoded matrix.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX frequent-sets`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: min_support
    type:
      - 'null'
      - float
    doc: "Minimum support (default 0.5)"
    inputBinding:
      position: 20
      prefix: --min-support
outputs:
  - id: stdout
    type: stdout
    doc: "Frequent item sets with their support"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: frequent-sets
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_frequent-sets.out
