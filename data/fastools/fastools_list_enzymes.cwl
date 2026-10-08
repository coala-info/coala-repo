cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - list_enzymes
label: fastools_list_enzymes
doc: "Return a list of supported restiction enzymes.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_list_enzymes.out
