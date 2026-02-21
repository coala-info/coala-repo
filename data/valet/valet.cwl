cwlVersion: v1.2
class: CommandLineTool
baseCommand: valet
label: valet
doc: "A tool for validation of assembly and error correction (Note: The provided text
  is an error log and does not contain help documentation; description and arguments
  could not be extracted from the source text).\n\nTool homepage: https://github.com/marbl/VALET"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/valet:1.0--3
stdout: valet.out
