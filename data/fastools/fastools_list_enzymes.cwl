cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_list_enzymes
label: fastools_list_enzymes
doc: "List of restriction enzymes.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: enzyme_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional list of enzyme names to filter by.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_list_enzymes.out
