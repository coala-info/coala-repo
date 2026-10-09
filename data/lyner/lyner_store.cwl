cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_store
doc: "Save current selection in given file; in tsv format.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX store`.\n\nTool homepage: https://github.com/tedil/lyner"
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
    doc: "Output format: csv, pickle or auto (default auto)"
    inputBinding:
      position: 20
      prefix: --mode
  - id: out_name
    type: string
    doc: "Output file name (tsv written with the header Feature)"
    inputBinding:
      position: 21
outputs:
  - id: stored_matrix
    type: File
    doc: Matrix written by store
    outputBinding:
      glob: $(inputs.out_name)
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: store
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_store.out
