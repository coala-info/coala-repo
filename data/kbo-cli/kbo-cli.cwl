cwlVersion: v1.2
class: CommandLineTool
baseCommand: kbo-cli
label: kbo-cli
doc: "The provided text contains system error logs and container runtime information
  rather than the tool's help documentation. As a result, no specific functionality
  or arguments could be extracted.\n\nTool homepage: https://docs.rs/kbo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
stdout: kbo-cli.out
