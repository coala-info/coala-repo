cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - maxbin
label: metagem_maxbin
doc: "The provided text contains only system error messages related to a container
  runtime failure and does not include the tool's help documentation. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_maxbin.out
