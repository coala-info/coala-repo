cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_plot_cladogram.py
label: lefse_lefse_plot_cladogram.py
doc: "Plot the LEfSe result as a cladogram on the feature hierarchy.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: 'tab delimited input file (the LEfSe result file)'
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: 'the file for the output image'
    inputBinding:
      position: 2
  - id: clade_sep
    type:
      - 'null'
      - float
    doc: 'Separation between clades'
    inputBinding:
      position: 10
      prefix: --clade_sep
  - id: max_lev
    type:
      - 'null'
      - int
    doc: 'Maximum level of the clades to be plotted'
    inputBinding:
      position: 10
      prefix: --max_lev
  - id: max_point_size
    type:
      - 'null'
      - float
    doc: 'Maximum point size'
    inputBinding:
      position: 10
      prefix: --max_point_size
  - id: min_point_size
    type:
      - 'null'
      - float
    doc: 'Minimum point size'
    inputBinding:
      position: 10
      prefix: --min_point_size
  - id: point_edge_width
    type:
      - 'null'
      - float
    doc: 'Width of the point edges'
    inputBinding:
      position: 10
      prefix: --point_edge_width
  - id: siblings_connector_width
    type:
      - 'null'
      - float
    doc: 'Width of the connectors between siblings'
    inputBinding:
      position: 10
      prefix: --siblings_connector_width
  - id: parents_connector_width
    type:
      - 'null'
      - float
    doc: 'Width of the connectors to parents'
    inputBinding:
      position: 10
      prefix: --parents_connector_width
  - id: radial_start_lev
    type:
      - 'null'
      - int
    doc: 'Level at which the radial layout starts'
    inputBinding:
      position: 10
      prefix: --radial_start_lev
  - id: labeled_start_lev
    type:
      - 'null'
      - int
    doc: 'First level that gets labels'
    inputBinding:
      position: 10
      prefix: --labeled_start_lev
  - id: labeled_stop_lev
    type:
      - 'null'
      - int
    doc: 'Last level that gets labels'
    inputBinding:
      position: 10
      prefix: --labeled_stop_lev
  - id: abrv_start_lev
    type:
      - 'null'
      - int
    doc: 'First level whose labels are abbreviated'
    inputBinding:
      position: 10
      prefix: --abrv_start_lev
  - id: abrv_stop_lev
    type:
      - 'null'
      - int
    doc: 'Last level whose labels are abbreviated'
    inputBinding:
      position: 10
      prefix: --abrv_stop_lev
  - id: expand_void_lev
    type:
      - 'null'
      - int
    doc: 'Level at which void clades are expanded'
    inputBinding:
      position: 10
      prefix: --expand_void_lev
  - id: class_legend_vis
    type:
      - 'null'
      - int
    doc: 'Show the class legend (1) or not (0)'
    inputBinding:
      position: 10
      prefix: --class_legend_vis
  - id: colored_connector
    type:
      - 'null'
      - int
    doc: 'Color the connectors (1) or not (0)'
    inputBinding:
      position: 10
      prefix: --colored_connector
  - id: alpha
    type:
      - 'null'
      - float
    doc: 'Transparency of the clade shading'
    inputBinding:
      position: 10
      prefix: --alpha
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title of the plot'
    inputBinding:
      position: 10
      prefix: --title
  - id: sub_clade
    type:
      - 'null'
      - string
    doc: 'Plot only this sub-clade'
    inputBinding:
      position: 10
      prefix: --sub_clade
  - id: title_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the title'
    inputBinding:
      position: 10
      prefix: --title_font_size
  - id: right_space_prop
    type:
      - 'null'
      - float
    doc: 'Proportion of free space on the right'
    inputBinding:
      position: 10
      prefix: --right_space_prop
  - id: left_space_prop
    type:
      - 'null'
      - float
    doc: 'Proportion of free space on the left'
    inputBinding:
      position: 10
      prefix: --left_space_prop
  - id: label_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the labels'
    inputBinding:
      position: 10
      prefix: --label_font_size
  - id: background_color
    type:
      - 'null'
      - string
    doc: 'Color of the background: k (black) or w (white)'
    inputBinding:
      position: 10
      prefix: --background_color
  - id: colored_labels
    type:
      - 'null'
      - int
    doc: 'Draw the label with the class color (1) or in black (0)'
    inputBinding:
      position: 10
      prefix: --colored_labels
  - id: class_legend_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the class legend'
    inputBinding:
      position: 10
      prefix: --class_legend_font_size
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Resolution of the output image'
    inputBinding:
      position: 10
      prefix: --dpi
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of the output file: png, svg or pdf'
    inputBinding:
      position: 10
      prefix: --format
  - id: all_feats
    type:
      - 'null'
      - string
    doc: 'Features to plot (separated by colons)'
    inputBinding:
      position: 10
      prefix: --all_feats
outputs:
  - id: output_file_out
    type: File
    doc: 'The cladogram image'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
