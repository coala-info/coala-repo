cwlVersion: v1.2
class: CommandLineTool
baseCommand: popdel
label: popdel
doc: "No description available: The provided text contains container runtime logs
  rather than tool help text.\n\nTool homepage: https://github.com/kehrlab/PopDel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
stdout: popdel.out
