cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5tools
label: slow5tools
doc: "The provided text is a container execution log and does not contain help information
  or argument definitions for slow5tools.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools.out
