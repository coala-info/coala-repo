cwlVersion: v1.2
class: CommandLineTool
baseCommand: digestiflow-cli
label: digestiflow-cli
doc: "Digestiflow CLI tool (Note: The provided text contains system error logs regarding
  a container build failure and does not contain help documentation; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/bihealth/digestiflow-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/digestiflow-cli:0.5.8--hc234bb7_7
stdout: digestiflow-cli.out
