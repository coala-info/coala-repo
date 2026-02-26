cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk list
label: snk_list
doc: "List the installed workflows.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show the workflow paths.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_list.out
