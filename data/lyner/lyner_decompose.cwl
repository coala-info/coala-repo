cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_decompose
doc: "Decomposition/dimensionality reduction (PCA, ICA, …)\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX decompose show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: mode
    type:
      - 'null'
      - string
    doc: "Method: PCA, KPCA, NMF, BMF, TSNE or ICA (default PCA)"
    inputBinding:
      position: 20
      prefix: --mode
  - id: decode
    type:
      - 'null'
      - boolean
    doc: "Apply the inverse transformation after decomposition"
    inputBinding:
      position: 20
      prefix: --decode
  - id: num_components
    type:
      - 'null'
      - int
    doc: "Number of components (default 2)"
    inputBinding:
      position: 20
      prefix: --num-components
  - id: mode_config
    type:
      - 'null'
      - string
    doc: "Extra parameters of the decomposition as key=value pairs separated by commas"
    inputBinding:
      position: 20
      prefix: --mode-config
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: decompose
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_decompose.out
