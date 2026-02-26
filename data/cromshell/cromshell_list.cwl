cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromshell_list
label: cromshell_list
doc: "List the status of workflows.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: color
    type:
      - 'null'
      - boolean
    doc: Color the output by completion status.
    inputBinding:
      position: 101
      prefix: --color
  - id: update
    type:
      - 'null'
      - boolean
    doc: Check completion status of all unfinished jobs.
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_list.out
