cwlVersion: v1.2
class: CommandLineTool
baseCommand: vawk
label: vawk
doc: "The provided text is a container engine error log and does not contain help
  information or argument definitions for the tool 'vawk'.\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vawk:0.0.2--py27_0
stdout: vawk.out
