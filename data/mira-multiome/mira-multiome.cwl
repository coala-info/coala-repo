cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira-multiome
label: mira-multiome
doc: "MIRA (Multi-omics Joint Latent Variable Analysis) tool for single-cell multiomics
  data integration.\n\nTool homepage: https://mira-multiome.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mira-multiome:2.1.1--pyhdfd78af_0
stdout: mira-multiome.out
