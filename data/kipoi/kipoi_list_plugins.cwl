cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - list_plugins
label: kipoi_list_plugins
doc: "Lists available plugins\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Table of the available plugins and whether they are installed
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_list_plugins.out
