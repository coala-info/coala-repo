cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustynuc
label: rustynuc
doc: "The provided text does not contain help documentation for rustynuc; it is an
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  tool's image.\n\nTool homepage: https://github.com/bjohnnyd/rustynuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustynuc:0.3.1--h577a1d6_3
stdout: rustynuc.out
