cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy_plugin
label: genomepy_plugin
doc: "Enable or disable plugins.\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: command
    type: string
    doc: Command to execute (list, enable, disable)
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - type: array
        items: string
    doc: Name(s) of plugins
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_plugin.out
