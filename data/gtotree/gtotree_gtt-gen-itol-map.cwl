cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-gen-itol-map
label: gtotree_gtt-gen-itol-map
doc: "Creates a standard iToL \"label\" and/or \"branch\" color file when given the IDs of the genomes you want to color.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: target_genomes
    type: File
    doc: "Single-column file with the genomes to color (need to match the IDs in the tree file, with no \">\")"
    inputBinding:
      position: 1
      prefix: -g
  - id: what_to_color
    type:
      - 'null'
      - string
    doc: "What to color, must be: \"branches\", \"labels\", or \"both\""
    default: both
    inputBinding:
      position: 2
      prefix: -w
  - id: color
    type:
      - 'null'
      - string
    doc: "Color to use of either: \"blue\", \"green\", or \"red\""
    default: blue
    inputBinding:
      position: 3
      prefix: -c
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file for iToL"
    default: iToL-colors.txt
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: itol_colors
    type: File
    doc: "iToL color file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
