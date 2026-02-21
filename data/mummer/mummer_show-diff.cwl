cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-diff
label: mummer_show-diff
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error message regarding container image conversion and disk space.\n
  \nTool homepage: https://github.com/mummer4/mummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321h503566f_21
stdout: mummer_show-diff.out
