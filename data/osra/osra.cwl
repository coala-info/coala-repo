cwlVersion: v1.2
class: CommandLineTool
baseCommand: osra
label: osra
doc: "Optical Structure Recognition Application (OSRA) is a tool designed to convert
  images of chemical structures into computer-readable formats.\n\nTool homepage:
  http://cactus.nci.nih.gov/osra/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/osra:2.1.0--0
stdout: osra.out
