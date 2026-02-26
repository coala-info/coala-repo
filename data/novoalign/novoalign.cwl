cwlVersion: v1.2
class: CommandLineTool
baseCommand: ps
label: novoalign
doc: "Show list of processes\n\nTool homepage: http://www.novocraft.com/products/novoalign/"
inputs:
  - id: columns
    type:
      - 'null'
      - string
    doc: Select columns for display
    inputBinding:
      position: 101
      prefix: -o
  - id: show_threads
    type:
      - 'null'
      - boolean
    doc: Show threads
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h43eeafb_3
stdout: novoalign.out
