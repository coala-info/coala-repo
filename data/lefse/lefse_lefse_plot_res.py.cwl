cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_plot_res.py
label: lefse_lefse_plot_res.py
doc: "Plot the LEfSe result as a histogram of the effect sizes (LDA scores).\n\nTool homepage: https://github.com/SegataLab/lefse"
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
  - id: feature_font_size
    type:
      - 'null'
      - int
    doc: 'Font size of the feature names'
    inputBinding:
      position: 10
      prefix: --feature_font_size
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of the output file: png, svg or pdf'
    inputBinding:
      position: 10
      prefix: --format
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Resolution of the output image'
    inputBinding:
      position: 10
      prefix: --dpi
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title of the plot'
    inputBinding:
      position: 10
      prefix: --title
  - id: title_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the title'
    inputBinding:
      position: 10
      prefix: --title_font_size
  - id: class_legend_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the class legend'
    inputBinding:
      position: 10
      prefix: --class_legend_font_size
  - id: width
    type:
      - 'null'
      - float
    doc: 'Width of the figure'
    inputBinding:
      position: 10
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: 'Height of the figure (only for vertical histograms)'
    inputBinding:
      position: 10
      prefix: --height
  - id: left_space
    type:
      - 'null'
      - float
    doc: 'Proportion of free space on the left'
    inputBinding:
      position: 10
      prefix: --left_space
  - id: right_space
    type:
      - 'null'
      - float
    doc: 'Proportion of free space on the right'
    inputBinding:
      position: 10
      prefix: --right_space
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'Orientation of the histogram: h or v'
    inputBinding:
      position: 10
      prefix: --orientation
  - id: autoscale
    type:
      - 'null'
      - int
    doc: 'Scale the axis automatically (1) or not (0)'
    inputBinding:
      position: 10
      prefix: --autoscale
  - id: background_color
    type:
      - 'null'
      - string
    doc: 'Color of the background: k (black) or w (white)'
    inputBinding:
      position: 10
      prefix: --background_color
  - id: subclades
    type:
      - 'null'
      - int
    doc: 'Number of label levels to display, starting from the leaves (-1 means all levels)'
    inputBinding:
      position: 10
      prefix: --subclades
  - id: max_feature_len
    type:
      - 'null'
      - int
    doc: 'Maximum length of the feature strings'
    inputBinding:
      position: 10
      prefix: --max_feature_len
  - id: all_feats
    type:
      - 'null'
      - string
    doc: 'Features to plot (separated by colons)'
    inputBinding:
      position: 10
      prefix: --all_feats
  - id: otu_only
    type:
      - 'null'
      - boolean
    doc: 'Plot only species resolved OTUs (as opposed to all levels)'
    inputBinding:
      position: 10
      prefix: --otu_only
  - id: report_features
    type:
      - 'null'
      - boolean
    doc: 'Report important features to standard output'
    inputBinding:
      position: 10
      prefix: --report_features
outputs:
  - id: output_file_out
    type: File
    doc: 'The bar plot image'
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: 'Standard output (important features with --report_features)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
