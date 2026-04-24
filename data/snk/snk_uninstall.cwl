cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk uninstall
label: snk_uninstall
doc: "Uninstall a workflow.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: name
    type: string
    doc: Name of the workflow to uninstall.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force uninstall without asking.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_uninstall.out
