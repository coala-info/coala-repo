cwlVersion: v1.2
class: CommandLineTool
baseCommand: ascli
label: aspera-cli_ascli
doc: "Aspera CLI tool for file transfer and management. Note: The provided help text
  contains a Ruby LoadError (missing 'webrick') and does not list available arguments.\n
  \nTool homepage: https://github.com/IBM/aspera-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0
stdout: aspera-cli_ascli.out
