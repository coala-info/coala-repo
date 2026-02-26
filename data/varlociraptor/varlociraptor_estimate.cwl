cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor estimate
label: varlociraptor_estimate
doc: "Perform estimations.\n\nTool homepage: https://varlociraptor.github.io"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands are: alignment-properties,
      contamination, help, mutational-burden.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
stdout: varlociraptor_estimate.out
