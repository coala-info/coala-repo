cwlVersion: v1.2
class: CommandLineTool
baseCommand: kbo
label: kbo-cli_kbo
doc: "Knowledge Base Operations CLI (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://docs.rs/kbo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
stdout: kbo-cli_kbo.out
