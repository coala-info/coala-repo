cwlVersion: v1.2
class: CommandLineTool
baseCommand: pb-falconc
label: pb-falconc
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-falconc:1.15.0--h41535f3_3
stdout: pb-falconc.out
