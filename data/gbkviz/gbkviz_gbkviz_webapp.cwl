cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbkviz_webapp
label: gbkviz_gbkviz_webapp
doc: "A tool for GenBank visualization (webapp). Note: The provided help text contains
  only system error messages regarding container image building and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/moshi4/GBKviz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbkviz:1.2.0--pyhdfd78af_0
stdout: gbkviz_gbkviz_webapp.out
