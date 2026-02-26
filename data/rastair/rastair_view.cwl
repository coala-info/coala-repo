cwlVersion: v1.2
class: CommandLineTool
baseCommand: rastair_view
label: rastair_view
doc: "View internal format as JSON lines\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs:
  - id: input
    type: File
    doc: Message Pack file to view
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable more logging\nYou can also use the `RASTAIR_LOG` environment variable
      to configure logging in a more precise way. See the documentation of the `tracing-subscriber`
      library to learn more."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Message Pack file to view
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
