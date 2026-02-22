cwlVersion: v1.2
class: CommandLineTool
baseCommand: conduit-assembler
label: conduit-assembler
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a Singularity/Docker container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler.out
