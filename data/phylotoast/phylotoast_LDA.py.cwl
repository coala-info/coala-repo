cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LDA.py
label: phylotoast_LDA.py
doc: "This script calculates and returns LDA plots based on normalized relative abundances or distance matrices (for e.g. unifrac distance matrix).\n\nTool homepage: https://github.com/smdabdoub/phylotoast"
inputs:
  - id: map_fp
    type: File
    doc: "Metadata mapping file."
    inputBinding:
      position: 1
      prefix: "--map_fp"
  - id: group_by
    type: string
    doc: "A column name in the mapping file containing categorical values that will be used to identify groups. Each sample ID must have a group entry."
    inputBinding:
      position: 2
      prefix: "--group_by"
  - id: colors
    type:
      - 'null'
      - string
    doc: "A column name in the mapping file containing hexadecimal (#FF0000) color values that will be used to color the groups. Each sample ID must have a color entry."
    inputBinding:
      position: 3
      prefix: "--colors"
  - id: otu_table
    type:
      - 'null'
      - File
    doc: "Input biom file format OTU table."
    inputBinding:
      position: 4
      prefix: "--otu_table"
  - id: dist_matrix_file
    type:
      - 'null'
      - File
    doc: "Input distance matrix file."
    inputBinding:
      position: 5
      prefix: "--dist_matrix_file"
  - id: save_lda_input
    type:
      - 'null'
      - string
    doc: "Save a CSV-format file of the transposed LDA-input table to the file specified by this option."
    inputBinding:
      position: 6
      prefix: "--save_lda_input"
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "Plot title. Default is no title."
    inputBinding:
      position: 7
      prefix: "--plot_title"
  - id: out_fp
    type: string
    doc: "The path and file name to save the LDA plot under (the figure is saved directly instead of opening a window)."
    inputBinding:
      position: 8
      prefix: "--out_fp"
  - id: dimensions
    type:
      - 'null'
      - int
    doc: "Choose whether to plot 2D or 3D (2 or 3). Default is a 2D view."
    inputBinding:
      position: 9
      prefix: "--dimensions"
  - id: z_angles
    type:
      - 'null'
      - type: array
        items: float
    doc: "Specify the azimuth and elevation angles for a 3D plot (two values)."
    inputBinding:
      position: 10
      prefix: "--z_angles"
  - id: figsize
    type:
      - 'null'
      - type: array
        items: float
    doc: "Specify the 'width height' in inches for LDA plots (two values). Default figure size is 14x8 inches."
    inputBinding:
      position: 11
      prefix: "--figsize"
  - id: font_size
    type:
      - 'null'
      - int
    doc: "Sets the font size for text elements in the plot."
    inputBinding:
      position: 12
      prefix: "--font_size"
  - id: label_padding
    type:
      - 'null'
      - int
    doc: "Sets the spacing in points between the each axis and its label."
    inputBinding:
      position: 13
      prefix: "--label_padding"
  - id: annotate_points
    type:
      - 'null'
      - boolean
    doc: "If specified, each data point will be labeled with its sample ID. Default is False."
    inputBinding:
      position: 14
      prefix: "--annotate_points"
  - id: ggplot2_style
    type:
      - 'null'
      - boolean
    doc: "Apply ggplot2 styling to the figure. Default is False."
    inputBinding:
      position: 15
      prefix: "--ggplot2_style"
outputs:
  - id: lda_plot
    type:
      - 'null'
      - File
    doc: "LDA plot"
    outputBinding:
      glob: "$(inputs.out_fp)"
  - id: lda_input
    type:
      - 'null'
      - File
    doc: "CSV file of the transposed LDA-input table"
    outputBinding:
      glob: "$(inputs.save_lda_input)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MPLBACKEND
        envValue: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylotoast:1.4.0rc2--py27_0
stdout: phylotoast_LDA.py.out
