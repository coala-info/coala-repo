cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq
label: fq
doc: "The provided text does not contain help information for the tool 'fq'. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/stjude-rust-labs/fq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
stdout: fq.out
