cwlVersion: v1.2
class: CommandLineTool
baseCommand: aviary
label: aviary
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a Singularity/Docker container execution
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/rhysnewell/aviary/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aviary:0.12.0--pyhdfd78af_0
stdout: aviary.out
