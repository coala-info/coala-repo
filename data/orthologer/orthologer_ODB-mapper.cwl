cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthologer_ODB-mapper
label: orthologer_ODB-mapper
doc: "Orthologer ODB-mapper (Note: The provided input text contained system error
  logs rather than help documentation, so no arguments could be parsed.)\n\nTool homepage:
  https://orthologer.ezlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthologer:3.9.0--py312hf097cbd_0
stdout: orthologer_ODB-mapper.out
