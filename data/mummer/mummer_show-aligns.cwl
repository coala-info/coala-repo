cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-aligns
label: mummer_show-aligns
doc: "The provided text contains system error messages and does not include the help
  documentation for the tool. As a result, no arguments could be extracted.\n\nTool
  homepage: https://github.com/mummer4/mummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321h503566f_21
stdout: mummer_show-aligns.out
