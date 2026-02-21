cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexserv
label: flexserv
doc: "FlexServ is a tool for macromolecular flexibility analysis. (Note: The provided
  text contains container runtime error messages rather than the tool's help documentation,
  so specific arguments could not be extracted.)\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/adam/FlexServ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexserv:1.0.2--hb2a3317_3
stdout: flexserv.out
