cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - custommargin
label: pauvre_custommargin
doc: "Generate custom margin plots from tab-separated data files.\n\nTool homepage:
  https://github.com/conchoecia/gloTK"
inputs:
  - id: add_yaxes
    type:
      - 'null'
      - boolean
    doc: Add Y-axes to both marginal histograms.
    inputBinding:
      position: 101
      prefix: --add-yaxes
  - id: dpi
    type:
      - 'null'
      - int
    doc: Change the dpi from the default 600 if you need it higher
    inputBinding:
      position: 101
      prefix: --dpi
  - id: fileform
    type:
      - 'null'
      - type: array
        items: string
    doc: Which output format would you like? Def.=png
    inputBinding:
      position: 101
      prefix: --fileform
  - id: input_file
    type:
      - 'null'
      - File
    doc: A tab-separated file with a header row of column names.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: no_timestamp
    type:
      - 'null'
      - boolean
    doc: Turn off time stamps in the filename output.
    inputBinding:
      position: 101
      prefix: --no_timestamp
  - id: no_transparent
    type:
      - 'null'
      - boolean
    doc: Specify this option if you don't want a transparent background. Default is
      on.
    inputBinding:
      position: 101
      prefix: --no_transparent
  - id: plot_max_x
    type:
      - 'null'
      - float
    doc: Sets the maximum viewing area in the quality dimension.
    inputBinding:
      position: 101
      prefix: --plot_max_x
  - id: plot_max_y
    type:
      - 'null'
      - float
    doc: Sets the maximum viewing area in the length dimension.
    inputBinding:
      position: 101
      prefix: --plot_max_y
  - id: plot_min_x
    type:
      - 'null'
      - float
    doc: Sets the minimum viewing area in the quality dimension. Default value = 0
    inputBinding:
      position: 101
      prefix: --plot_min_x
  - id: plot_min_y
    type:
      - 'null'
      - float
    doc: Sets the minimum viewing area in the length dimension. Default value = 0
    inputBinding:
      position: 101
      prefix: --plot_min_y
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: square
    type:
      - 'null'
      - boolean
    doc: changes the hexmap into a square map quantized by ints.
    inputBinding:
      position: 101
      prefix: --square
  - id: title
    type:
      - 'null'
      - string
    doc: This sets the title for the whole plot. Use --title "Crustacean's DNA read
      quality" if you need single quote or apostrophe inside title.
    inputBinding:
      position: 101
      prefix: --title
  - id: xbin
    type:
      - 'null'
      - int
    doc: This sets the bin size to use for quality
    inputBinding:
      position: 101
      prefix: --xbin
  - id: xcol
    type:
      - 'null'
      - string
    doc: The column name of the data to plot on the x-axis
    inputBinding:
      position: 101
      prefix: --xcol
  - id: ybin
    type:
      - 'null'
      - int
    doc: This sets the bin size to use for length.
    inputBinding:
      position: 101
      prefix: --ybin
  - id: ycol
    type:
      - 'null'
      - string
    doc: The column name of the data to plot on the y-axis
    inputBinding:
      position: 101
      prefix: --ycol
outputs:
  - id: output_base_name
    type:
      - 'null'
      - File
    doc: Specify a base name for the output file(s). The input file base name is the
      default.
    outputBinding:
      glob: $(inputs.output_base_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
