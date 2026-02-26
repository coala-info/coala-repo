cwlVersion: v1.2
class: CommandLineTool
baseCommand: airr-tools
label: airr_airr-tools
doc: "AIRR Community Standards utility commands.\n\nTool homepage: http://docs.airr-community.org"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (merge or validate)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/airr:1.6.1--pyh106432d_0
stdout: airr_airr-tools.out
