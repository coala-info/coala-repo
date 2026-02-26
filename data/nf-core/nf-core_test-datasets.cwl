cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-core test-datasets
label: nf-core_test-datasets
doc: "Commands to manage nf-core test datasets.\n\nTool homepage: http://nf-co.re/"
inputs:
  - id: command
    type: string
    doc: Command to execute (list, list-branches, search)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
stdout: nf-core_test-datasets.out
