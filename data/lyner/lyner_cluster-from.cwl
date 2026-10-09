cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_cluster-from
doc: "Use cluster indices from file.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX cluster-from show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: cluster_file
    type: File
    doc: "tsv file with a header; first column: sample name, second column: cluster number"
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
    valueFrom: cluster-from
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster-from.out
