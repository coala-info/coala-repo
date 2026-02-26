cwlVersion: v1.2
class: CommandLineTool
baseCommand: scarap
label: scarap
doc: "scarap: error: unrecognized arguments: -elp\n\nTool homepage: https://pypi.org/project/scarap"
inputs:
  - id: subcommand
    type: string
    doc: 'Available subcommands: pan, core, build, search, concat, sample, checkgenomes,
      checkgroups, filter, fetch'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
stdout: scarap.out
