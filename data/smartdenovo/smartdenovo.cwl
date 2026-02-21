cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo
label: smartdenovo
doc: "The provided text is a container engine error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo.out
