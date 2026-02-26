cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor plot
label: varlociraptor_plot
doc: "Create plots\n\nTool homepage: https://varlociraptor.github.io"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
stdout: varlociraptor_plot.out
