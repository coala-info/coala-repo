cwlVersion: v1.2
class: CommandLineTool
baseCommand: callerpp
label: callerpp
doc: "The provided text does not contain help information or usage instructions for
  callerpp. It contains system logs and a fatal error regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/nh13/callerpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callerpp:0.1.6--h503566f_2
stdout: callerpp.out
