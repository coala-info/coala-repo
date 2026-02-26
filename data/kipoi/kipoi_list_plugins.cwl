cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi_list_plugins
label: kipoi_list_plugins
doc: "List installed Kipoi plugins\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: plugin
    type: string
    doc: Plugin name
    inputBinding:
      position: 1
  - id: description
    type: string
    doc: Description of the plugin
    inputBinding:
      position: 2
  - id: url
    type: string
    doc: URL of the plugin
    inputBinding:
      position: 3
  - id: cli
    type:
      - 'null'
      - boolean
    doc: Whether the plugin has a CLI
    inputBinding:
      position: 104
  - id: installed
    type:
      - 'null'
      - boolean
    doc: Whether the plugin is installed
    inputBinding:
      position: 104
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_list_plugins.out
