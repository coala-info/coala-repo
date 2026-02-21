cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsm-lite
label: fsm-lite
doc: "Frequency-based String Mining (Note: The provided text is a container runtime
  error log and does not contain the tool's help documentation or usage instructions.)\n
  \nTool homepage: https://github.com/nvalimak/fsm-lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fsm-lite:v1.0-3-deb_cv1
stdout: fsm-lite.out
