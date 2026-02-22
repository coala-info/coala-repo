cwlVersion: v1.2
class: CommandLineTool
baseCommand: conservation
label: conservation
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains error messages related to a container runtime
  environment (Singularity/Docker) failing due to insufficient disk space.\n\nTool
  homepage: https://github.com/hanjunlee21/conservation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conservation:1.0.1--pyhdfd78af_0
stdout: conservation.out
