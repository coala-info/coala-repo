cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_pairwise-distances
doc: "Calculate pairwise distances between rows of the data matrix.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX pairwise-distances show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: metric
    type:
      - 'null'
      - string
    doc: "Distance metric, for example euclidean, cityblock, correlation, cosine or jaccard (default euclidean)"
    inputBinding:
      position: 20
      prefix: --metric
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: pairwise-distances
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_pairwise-distances.out
