cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grz-cli
  - decompress
label: grz-cli_decompress
doc: "Decompress files using grz-cli (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://pypi.org/project/grz-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
stdout: grz-cli_decompress.out
