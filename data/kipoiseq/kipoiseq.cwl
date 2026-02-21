cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoiseq
label: kipoiseq
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/kipoi/kipoiseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoiseq:0.7.1--pyhdfd78af_0
stdout: kipoiseq.out
