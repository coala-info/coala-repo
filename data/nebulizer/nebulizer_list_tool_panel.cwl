cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - list_tool_panel
label: nebulizer_list_tool_panel
doc: "List tool panel contents.\n\n  Prints details of tool panel sections including
  the displayed text and the\n  internal section id, and any tools available outside
  of any section.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY instance to query
    inputBinding:
      position: 1
  - id: list_tools
    type:
      - 'null'
      - boolean
    doc: also list the associated tools for each section
    inputBinding:
      position: 102
      prefix: --list-tools
  - id: name
    type:
      - 'null'
      - string
    doc: "only list tool panel sections where name or id match NAME. Can\n       \
      \         include glob-style wild-cards."
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_tool_panel.out
