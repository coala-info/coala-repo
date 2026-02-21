cwlVersion: v1.2
class: CommandLineTool
baseCommand: yasm
label: yasm
doc: "The provided text does not contain help information for yasm; it appears to
  be an error log from a container runtime (Apptainer/Singularity) failing to fetch
  the yasm image.\n\nTool homepage: https://github.com/yasm/yasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasm:1.3.0--0
stdout: yasm.out
