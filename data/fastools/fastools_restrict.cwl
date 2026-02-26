cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools restrict
label: fastools_restrict
doc: "Fragment a genome with restriction enzymes.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: restriction_enzyme
    type:
      - 'null'
      - type: array
        items: string
    doc: restriction enzyme (use multiple times for more enzymes)
    inputBinding:
      position: 102
      prefix: --restriction_enzyme
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_restrict.out
