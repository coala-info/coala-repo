cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem_concoct
label: metagem_concoct
doc: "Metagem concoct tool (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_concoct.out
