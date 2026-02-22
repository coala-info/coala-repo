cwlVersion: v1.2
class: CommandLineTool
baseCommand: comet-ms
label: comet-ms
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: http://comet-ms.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comet-ms:2024011--hb319eff_0
stdout: comet-ms.out
