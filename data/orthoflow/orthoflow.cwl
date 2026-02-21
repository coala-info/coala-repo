cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthoflow
label: orthoflow
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container execution
  (no space left on device).\n\nTool homepage: https://github.com/rbturnbull/orthoflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthoflow:0.3.4--pyhdfd78af_0
stdout: orthoflow.out
