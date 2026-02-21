cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonform
label: isonform
doc: "No description available: The provided text contains container runtime error
  messages rather than tool help text.\n\nTool homepage: https://github.com/aljpetri/isONform"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonform:0.3.4--pyh7cba7a3_0
stdout: isonform.out
