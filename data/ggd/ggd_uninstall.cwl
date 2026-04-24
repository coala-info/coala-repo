cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd uninstall
label: ggd_uninstall
doc: "Use ggd to uninstall a ggd data package installed in the current conda environment\n\
  \nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: names
    type:
      type: array
      items: string
    doc: the name(s) of the ggd package(s) to uninstall
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: The ggd channel of the recipe to uninstall.
    inputBinding:
      position: 102
      prefix: --channel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_uninstall.out
