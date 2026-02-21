cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbkviz
label: gbkviz
doc: "A tool for GenBank data visualization (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/moshi4/GBKviz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbkviz:1.2.0--pyhdfd78af_0
stdout: gbkviz.out
