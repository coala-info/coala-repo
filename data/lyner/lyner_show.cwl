cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_show
doc: "Prints current selection to stdout, in tsv format.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
    type:
      - 'null'
      - File
    doc: "Experiment design (tsv with columns Sample, Class). Passed to `lyner design` before the command, so samples are grouped by class (optional). List the samples of each class together and the classes in alphabetical order: lyner design mislabels samples otherwise"
    inputBinding:
      position: 3
      prefix: design
outputs:
  - id: stdout
    type: stdout
    doc: "Matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_show.out
