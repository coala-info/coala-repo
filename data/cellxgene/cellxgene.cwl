cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellxgene
label: cellxgene
doc: "An interactive explorer for single-cell transcriptomics data. Note: The provided
  input text contains system error logs rather than tool help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://chanzuckerberg.github.io/cellxgene/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
stdout: cellxgene.out
