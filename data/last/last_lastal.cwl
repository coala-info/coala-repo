cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastal
label: last_lastal
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error message regarding a container runtime failure (no space left
  on device).\n\nTool homepage: https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_lastal.out
