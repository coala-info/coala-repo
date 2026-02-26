cwlVersion: v1.2
class: CommandLineTool
baseCommand: kbo
label: kbo-cli_kbo
doc: "kbo\n\nTool homepage: https://docs.rs/kbo"
inputs:
  - id: command
    type: string
    doc: Command to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
stdout: kbo-cli_kbo.out
