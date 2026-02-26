cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor filter-calls
label: varlociraptor_filter-calls
doc: "Filter calls by either controlling the false discovery rate (FDR) at given level,
  or by posterior odds against the given events.\n\nTool homepage: https://varlociraptor.github.io"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: control-fdr, help, posterior-odds'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
stdout: varlociraptor_filter-calls.out
