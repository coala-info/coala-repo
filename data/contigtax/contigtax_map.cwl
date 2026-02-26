cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax
label: contigtax_map
doc: "A tool for taxonomic assignment of contigs.\n\nTool homepage: https://github.com/NBISweden/contigtax"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to run. Available choices: download, format, update, build,
      search, assign, transfer.'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax_map.out
