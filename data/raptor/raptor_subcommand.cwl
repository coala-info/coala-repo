cwlVersion: v1.2
class: CommandLineTool
baseCommand: raptor_subcommand
label: raptor_subcommand
doc: "Please specify which sub-program you want to use: one of [build, layout, prepare,
  search, upgrade].\n\nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to use (build, layout, prepare, search, upgrade)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_subcommand.out
