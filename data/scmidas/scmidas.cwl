cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmidas
label: scmidas
doc: "scMIDAS (Single-cell Multi-omics Mosaic Integration via De novo Assembly of
  Subspaces). Note: The provided text contains system error messages regarding disk
  space and container image retrieval rather than tool help documentation.\n\nTool
  homepage: https://github.com/labomics/midas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmidas:0.1.15--pyhdfd78af_0
stdout: scmidas.out
