cwlVersion: v1.2
class: CommandLineTool
baseCommand: tendo
label: tendo
doc: "The provided text is a container build error log and does not contain help documentation
  or argument definitions for the tool 'tendo'.\n\nTool homepage: https://github.com/phom9/tendo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tendo:0.3.0--pyh7cba7a3_0
stdout: tendo.out
