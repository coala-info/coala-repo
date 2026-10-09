cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_targets
doc: "Include only/exclude all genes in the given file. One feature per line.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX targets show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: targets
    type:
      - 'null'
      - string
    doc: "Comma separated list of feature names"
    inputBinding:
      position: 20
      prefix: --targets
  - id: from_file
    type:
      - 'null'
      - File
    doc: "File with one feature name per line"
    inputBinding:
      position: 20
      prefix: --from-file
  - id: mode
    type:
      - 'null'
      - string
    doc: "exclude or intersect (default intersect)"
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
  - position: 10
    valueFrom: targets
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_targets.out
