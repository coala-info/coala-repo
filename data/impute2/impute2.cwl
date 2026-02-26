cwlVersion: v1.2
class: CommandLineTool
baseCommand: impute2
label: impute2
doc: "IMPUTE version 2.3.2\n\nTool homepage: https://github.com/johnlees/23andme-impute"
inputs:
  - id: interval
    type: string
    doc: Specify a valid interval for imputation
    inputBinding:
      position: 101
      prefix: -int
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impute2:2.3.2--1
stdout: impute2.out
