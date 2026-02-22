cwlVersion: v1.2
class: CommandLineTool
baseCommand: cosg
label: cosg
doc: "COSG is a method for accurate and fast marker gene identification for single-cell
  data.\n\nTool homepage: https://github.com/genecell/COSG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cosg:1.0.3--pyhdfd78af_0
stdout: cosg.out
