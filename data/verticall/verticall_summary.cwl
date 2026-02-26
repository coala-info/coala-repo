cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall summary
label: verticall_summary
doc: "summarise regions for one assembly\n\nTool homepage: https://github.com/rrwick/Verticall"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: 'Output one line for all assembly positions (default: omit redundant adjacent
      lines)'
    default: false
    inputBinding:
      position: 101
      prefix: --all
  - id: assembly
    type: File
    doc: Filename of assembly to be summarised
    inputBinding:
      position: 101
      prefix: --assembly
  - id: horizontal_colour
    type:
      - 'null'
      - string
    doc: Hex colour for horizontal inheritance
    default: '#c47e7e'
    inputBinding:
      position: 101
      prefix: --horizontal_colour
  - id: in_file
    type: File
    doc: Filename of TSV created by vertical pairwise
    inputBinding:
      position: 101
      prefix: --in_file
  - id: plot
    type:
      - 'null'
      - boolean
    doc: 'Instead of outputting a table, display an interactive plot (default: do
      not display a plot)'
    default: false
    inputBinding:
      position: 101
      prefix: --plot
  - id: unaligned_colour
    type:
      - 'null'
      - string
    doc: Hex colour for unaligned inheritance
    default: '#c9c9c9'
    inputBinding:
      position: 101
      prefix: --unaligned_colour
  - id: vertical_colour
    type:
      - 'null'
      - string
    doc: Hex colour for vertical inheritance
    default: '#4859a0'
    inputBinding:
      position: 101
      prefix: --vertical_colour
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
stdout: verticall_summary.out
