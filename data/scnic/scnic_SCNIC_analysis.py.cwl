cwlVersion: v1.2
class: CommandLineTool
baseCommand: SCNIC_analysis.py
label: scnic_SCNIC_analysis.py
doc: "SCNIC analysis tool\n\nTool homepage: https://github.com/shafferm/SCNIC"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run: within, modules, or between'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      type: array
      items: string
    doc: Arguments for the chosen subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
stdout: scnic_SCNIC_analysis.py.out
