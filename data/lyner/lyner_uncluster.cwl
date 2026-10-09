cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_uncluster
doc: "Remove grouping of samples/features into clusters.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX cluster-hierarchical uncluster show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: cluster_threshold
    type:
      - 'null'
      - float
    doc: "Threshold of the preceding `cluster-hierarchical` step (default 0.8)"
    inputBinding:
      position: 5
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 4
    valueFrom: cluster-hierarchical
  - position: 10
    valueFrom: uncluster
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_uncluster.out
