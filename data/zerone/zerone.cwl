cwlVersion: v1.2
class: CommandLineTool
baseCommand: zerone
label: zerone
doc: "The provided text is a container build error log and does not contain help information
  or usage instructions for the tool 'zerone'.\n\nTool homepage: https://github.com/nanakiksc/zerone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zerone:1.0--h577a1d6_9
stdout: zerone.out
