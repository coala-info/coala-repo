cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_cladogram.py
label: lefse_lefse_plot_cladogram.py
doc: "This script generates a cladogram representation of the LEfSe results.\n\nTool
  homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: The input file (the output of the LEfSe analysis)
    inputBinding:
      position: 1
  - id: clade_sep
    type:
      - 'null'
      - float
    doc: Separation between clades
    inputBinding:
      position: 102
      prefix: --clade_sep
  - id: dpi
    type:
      - 'null'
      - int
    doc: The DPI of the output image
    inputBinding:
      position: 102
      prefix: --dpi
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the output image (png, pdf, svg, jpg)
    inputBinding:
      position: 102
      prefix: --format
  - id: max_lev
    type:
      - 'null'
      - int
    doc: Maximum level of the clades to be plotted
    inputBinding:
      position: 102
      prefix: --max_lev
  - id: max_point_size
    type:
      - 'null'
      - float
    doc: Maximum point size
    inputBinding:
      position: 102
      prefix: --max_point_size
  - id: min_lev
    type:
      - 'null'
      - int
    doc: Minimum level of the clades to be plotted
    inputBinding:
      position: 102
      prefix: --min_lev
  - id: min_point_size
    type:
      - 'null'
      - float
    doc: Minimum point size
    inputBinding:
      position: 102
      prefix: --min_point_size
  - id: point_edge_width
    type:
      - 'null'
      - float
    doc: Width of the point edges
    inputBinding:
      position: 102
      prefix: --point_edge_width
  - id: title
    type:
      - 'null'
      - string
    doc: Title of the plot
    inputBinding:
      position: 102
      prefix: --title
outputs:
  - id: output_file
    type: File
    doc: The output image file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
