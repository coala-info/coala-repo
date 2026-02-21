cwlVersion: v1.2
class: CommandLineTool
baseCommand: to-mr
label: methpipe_to-mr
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding container execution and disk space.\n\nTool homepage:
  https://github.com/smithlabcode/methpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
stdout: methpipe_to-mr.out
