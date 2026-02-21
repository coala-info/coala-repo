cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct
label: dpcstruct
doc: "The provided text does not contain help information for dpcstruct; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
stdout: dpcstruct.out
