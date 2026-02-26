cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylip_retree
label: phylip_retree
doc: "Tree Rearrangement\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: graphics_type
    type:
      - 'null'
      - string
    doc: Graphics type (IBM PC, ANSI, none)
    inputBinding:
      position: 101
      prefix: '0'
  - id: initial_tree_type
    type:
      - 'null'
      - string
    doc: Initial tree (arbitrary, user, specify)
    inputBinding:
      position: 101
      prefix: U
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format to write out trees (PHYLIP, Nexus, XML)
    inputBinding:
      position: 101
      prefix: N
  - id: screen_lines
    type:
      - 'null'
      - int
    doc: Number of lines on screen
    inputBinding:
      position: 101
      prefix: L
  - id: terminal_width
    type:
      - 'null'
      - string
    doc: Width of terminal screen, of plotting area
    inputBinding:
      position: 101
      prefix: W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_retree.out
