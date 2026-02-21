cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-cli
label: varfish-cli
doc: "VarFish Command Line Interface\n\nTool homepage: https://github.com/bihealth/varfish-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
stdout: varfish-cli.out
