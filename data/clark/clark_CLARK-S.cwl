cwlVersion: v1.2
class: CommandLineTool
baseCommand: CLARK-S
label: clark_CLARK-S
doc: "CLARK-S is a tool for supervised sequence classification (part of the CLARK
  toolset). Note: The provided help text contains system error logs and does not list
  command-line arguments.\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark_CLARK-S.out
