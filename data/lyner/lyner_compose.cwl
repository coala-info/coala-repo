cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_compose
doc: "'Inverse' of `decompose`. Assumes `decompose` has been executed already.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX decompose compose show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: decompose_mode
    type:
      - 'null'
      - string
    doc: "Method of the preceding `decompose` step: PCA, KPCA, NMF, TSNE or ICA (default PCA)"
    inputBinding:
      position: 5
      prefix: --mode
  - id: decompose_num_components
    type:
      - 'null'
      - int
    doc: "Number of components of the preceding `decompose` step (default 2)"
    inputBinding:
      position: 5
      prefix: --num-components
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 4
    valueFrom: decompose
  - position: 10
    valueFrom: compose
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_compose.out
