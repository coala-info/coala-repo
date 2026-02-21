cwlVersion: v1.2
class: CommandLineTool
baseCommand: aligncov
label: aligncov
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message indicating a failure to build
  or extract the container image due to insufficient disk space ('no space left on
  device').\n\nTool homepage: https://github.com/pcrxn/aligncov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aligncov:0.0.2--pyh7cba7a3_0
stdout: aligncov.out
