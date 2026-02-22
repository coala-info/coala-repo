cwlVersion: v1.2
class: CommandLineTool
baseCommand: autobigs-cli
label: autobigs-cli
doc: "A command-line interface tool (Note: The provided text contains system error
  messages regarding disk space and container extraction rather than the tool's help
  documentation. No arguments could be extracted from the provided text.)\n\nTool
  homepage: https://github.com/RealYHD/autoBIGS.cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autobigs-cli:0.6.5--pyhdfd78af_0
stdout: autobigs-cli.out
