cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifiasm
label: hifiasm
doc: "The provided text does not contain help information for hifiasm; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/chhylp123/hifiasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifiasm:0.25.0--h5ca1c30_0
stdout: hifiasm.out
