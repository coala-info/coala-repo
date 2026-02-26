cwlVersion: v1.2
class: CommandLineTool
baseCommand: coast
label: coast_valid
doc: "COAST (Coastal Ocean Analysis and Statistics Tool) command-line interface for
  searching, reporting, retrieving, and comparing data.\n\nTool homepage: https://gitlab.com/coast_tool/COAST"
inputs:
  - id: subcommand
    type: string
    doc: 'The action to perform: search, report, retrieve, or compare'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coast:0.2.2--pyh5e36f6f_0
stdout: coast_valid.out
