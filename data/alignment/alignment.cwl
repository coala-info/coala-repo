cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignment
label: alignment
doc: "A tool for sequence alignment (Note: The provided text contains only system
  logs and build errors, no specific help documentation was found).\n\nTool homepage:
  https://github.com/eseraygun/python-alignment"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignment:1.0.10--pyh5e36f6f_0
stdout: alignment.out
