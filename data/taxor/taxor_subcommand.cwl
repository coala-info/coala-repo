cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxor
label: taxor_subcommand
doc: "This program must be invoked with one of the following subcommands: - build
  - search - profile See the respective help page for further details (e.g. by calling
  taxor build -h). The following options below belong to the top-level parser and
  need to be specified before the subcommand key word. Every argument after the subcommand
  key word is passed on to the corresponding sub-parser.\n\nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs:
  - id: export_help
    type:
      - 'null'
      - string
    doc: Export the help page information. Value must be one of [html, man]
    inputBinding:
      position: 101
      prefix: --export-help
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor_subcommand.out
