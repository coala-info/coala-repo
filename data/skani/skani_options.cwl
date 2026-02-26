cwlVersion: v1.2
class: CommandLineTool
baseCommand: skani
label: skani_options
doc: "skani\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs:
  - id: subcommand
    type: string
    doc: skani
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
stdout: skani_options.out
