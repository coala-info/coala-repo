cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools select
label: fastools_select
doc: "Select a substring from every read. Positions are one-based and inclusive.\n\
  \nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: first
    type: int
    doc: first base of the selection (int)
    inputBinding:
      position: 2
  - id: last
    type: int
    doc: last base of the selection (int)
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
