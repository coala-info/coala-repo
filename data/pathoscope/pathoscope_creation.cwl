cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathoscope_creation
label: pathoscope_creation
doc: "A tool for PathoScope database creation (Note: The provided help text is incomplete
  and only indicates a missing library dependency).\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
stdout: pathoscope_creation.out
