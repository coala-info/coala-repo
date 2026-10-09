cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_estimate
doc: "Fit the given distribution to each target(-cluster) and each (design-)group.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX estimate select estimate show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: distribution
    type:
      - 'null'
      - string
    doc: "Distribution to fit: negbinom, gamma, laisson, t, norm, cauchy, lognorm or any scipy.stats continuous distribution (default t)"
    inputBinding:
      position: 20
      prefix: --distribution
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: estimate
  - position: 50
    valueFrom: select
  - position: 51
    valueFrom: estimate
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_estimate.out
