cwlVersion: v1.2
class: CommandLineTool
baseCommand: kwip
label: kwip
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/kdmurray91/kWIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kwip:0.2.0--hd28b015_0
stdout: kwip.out
