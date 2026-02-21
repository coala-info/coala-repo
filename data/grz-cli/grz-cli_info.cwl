cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grz-cli
  - info
label: grz-cli_info
doc: "Display information about grz-cli\n\nTool homepage: https://pypi.org/project/grz-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
stdout: grz-cli_info.out
