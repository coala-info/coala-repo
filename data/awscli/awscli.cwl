cwlVersion: v1.2
class: CommandLineTool
baseCommand: aws
label: awscli
doc: "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services.\n\
  \nTool homepage: https://github.com/localstack/awscli-local"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/awscli:1.8.3--py35_0
stdout: awscli.out
