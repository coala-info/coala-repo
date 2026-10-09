cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_plot_features.py
label: lefse_lefse_plot_features.py
doc: "Plot the raw-data representation of the features found by LEfSe.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: dataset_file
    type: File
    doc: 'dataset file (the formatted LEfSe input)'
    inputBinding:
      position: 1
  - id: lefse_result
    type: File
    doc: 'LEfSe output file'
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: 'prefix of the output image files (or the zip file name with --archive zip)'
    inputBinding:
      position: 3
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
    doc: 'Height of the figure'
    inputBinding:
      position: 10
      prefix: --height
  - id: top
    type:
      - 'null'
      - float
    doc: 'Maximum y limit (-1.0 means automatic limit)'
    inputBinding:
      position: 10
      prefix: --top
  - id: bot
    type:
      - 'null'
      - float
    doc: 'Minimum y limit (default 0.0, -1.0 means automatic limit)'
    inputBinding:
      position: 10
      prefix: --bot
  - id: title_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the title'
    inputBinding:
      position: 10
      prefix: --title_font_size
  - id: class_font_size
    type:
      - 'null'
      - string
    doc: 'Font size of the class labels'
    inputBinding:
      position: 10
      prefix: --class_font_size
  - id: class_label_pos
    type:
      - 'null'
      - string
    doc: 'Position of the class labels: up or down'
    inputBinding:
      position: 10
      prefix: --class_label_pos
  - id: subcl_mean
    type:
      - 'null'
      - string
    doc: 'Draw the subclass mean: y or n'
    inputBinding:
      position: 10
      prefix: --subcl_mean
  - id: subcl_median
    type:
      - 'null'
      - string
    doc: 'Draw the subclass median: y or n'
    inputBinding:
      position: 10
      prefix: --subcl_median
  - id: font_size
    type:
      - 'null'
      - string
    doc: 'Font size'
    inputBinding:
      position: 10
      prefix: --font_size
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of the output file: png, pdf or svg'
    inputBinding:
      position: 10
      prefix: --format
  - id: plot_features
    type:
      - 'null'
      - string
    doc: 'Plot all features (all), only the differentially abundant ones (diff) or only one (one, given with feature_name)'
    inputBinding:
      position: 10
      prefix: -f
  - id: feature_name
    type:
      - 'null'
      - string
    doc: 'The name of the feature to plot (levels separated by .)'
    inputBinding:
      position: 10
      prefix: --feature_name
  - id: feature_num
    type:
      - 'null'
      - int
    doc: 'The number of the feature to plot'
    inputBinding:
      position: 10
      prefix: --feature_num
  - id: archive
    type:
      - 'null'
      - string
    doc: 'Archive the output files: zip or none'
    inputBinding:
      position: 10
      prefix: --archive
  - id: background_color
    type:
      - 'null'
      - string
    doc: 'Color of the background: k (black) or w (white)'
    inputBinding:
      position: 10
      prefix: --background_color
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Resolution of the output images'
    inputBinding:
      position: 10
      prefix: --dpi
outputs:
  - id: output_files
    type: File[]
    doc: 'Image files (or the zip archive) written with the given output prefix'
    outputBinding:
      glob: $(inputs.output_file)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
