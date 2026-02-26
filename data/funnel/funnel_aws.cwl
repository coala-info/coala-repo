cwlVersion: v1.2
class: CommandLineTool
baseCommand: funnel aws
label: funnel_aws
doc: "Development utilities for creating funnel resources on AWS\n\nTool homepage:
  https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: batch'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_aws.out
