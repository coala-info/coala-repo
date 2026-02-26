cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango
label: tango_map
doc: "Tango is a tool for mapping and analyzing genomic data.\n\nTool homepage: https://github.com/johnne/tango"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: download, format, update,
      build, search, assign, transfer.'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_map.out
