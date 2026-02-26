cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - read
label: lyner_read
doc: "Read abundance/count matrix from MATRIX (tsv format).\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: matrix
    type: File
    doc: TSV matrix file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_read.out
