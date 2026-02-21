cwlVersion: v1.2
class: CommandLineTool
baseCommand: sodar-cli
label: sodar-cli
doc: "SODAR Command Line Interface\n\nTool homepage: https://github.com/bihealth/sodar-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
stdout: sodar-cli.out
