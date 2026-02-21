cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy-scripts
label: scanpy-scripts
doc: "A collection of scripts for Scanpy, a scalable toolkit for analyzing single-cell
  gene expression data. (Note: The provided text contains container build logs and
  error messages rather than CLI help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
stdout: scanpy-scripts.out
