cwlVersion: v1.2
class: CommandLineTool
baseCommand: hatchet
label: hatchet
doc: "A tool for characterizing allele-specific copy number alterations (CNAs) and
  tumor fractions in bulk DNA sequencing data.\n\nTool homepage: https://github.com/raphael-group/hatchet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet.out
