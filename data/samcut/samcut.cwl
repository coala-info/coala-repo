cwlVersion: v1.2
class: CommandLineTool
baseCommand: samcut
label: samcut
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the 'samcut' tool. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/gshiba/samcut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samcut:0.1.1--h9948957_3
stdout: samcut.out
