cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastml
label: fastml
doc: "FastML is a bioinformatics tool for the reconstruction of ancestral phylogenetic
  sequences. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  http://fastml.tau.ac.il/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastml:3.11--hc9558a2_0
stdout: fastml.out
