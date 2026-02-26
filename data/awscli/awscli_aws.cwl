cwlVersion: v1.2
class: CommandLineTool
baseCommand: aws
label: awscli_aws
doc: "AWS Command Line Interface\n\nTool homepage: https://github.com/localstack/awscli-local"
inputs:
  - id: command
    type: string
    doc: The AWS command to execute
    inputBinding:
      position: 1
  - id: subcommand
    type:
      - 'null'
      - string
    doc: The subcommand for the AWS command
    inputBinding:
      position: 2
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters for the subcommand
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/awscli:1.8.3--py35_0
stdout: awscli_aws.out
