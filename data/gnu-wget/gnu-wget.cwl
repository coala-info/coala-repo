cwlVersion: v1.2
class: CommandLineTool
baseCommand: wget
label: gnu-wget
doc: "GNU Wget is a free utility for non-interactive download of files from the Web.
  (Note: The provided help text contains a system error message and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/darnir/wget"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnu-wget:1.18--hb829ee6_10
stdout: gnu-wget.out
