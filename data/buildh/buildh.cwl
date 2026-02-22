cwlVersion: v1.2
class: CommandLineTool
baseCommand: buildh
label: buildh
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs related to a Singularity/Docker container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/patrickfuchs/buildH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/buildh:1.6.1--pyhdfd78af_0
stdout: buildh.out
