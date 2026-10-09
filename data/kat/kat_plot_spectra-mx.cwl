cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kat
  - plot
  - spectra-mx
label: kat_plot_spectra-mx
doc: "Creates K-mer spectra plot from selected rows and/or columns in a kat comp matrix.\n\nTool homepage: https://github.com/TGAC/KAT"
inputs:
  - id: matrix_file
    type: File
    doc: "The input matrix file from KAT"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: kat-plot-spectra-mx.png
    doc: "The path to the output file."
    inputBinding:
      position: 10
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: "The plot file type to create (default is based on given output name)."
    inputBinding:
      position: 11
      prefix: --output_type
  - id: title
    type:
      - 'null'
      - string
    doc: "Title for plot"
    inputBinding:
      position: 12
      prefix: --title
  - id: x_label
    type:
      - 'null'
      - string
    doc: "Label for x-axis"
    inputBinding:
      position: 13
      prefix: --x_label
  - id: y_label
    type:
      - 'null'
      - string
    doc: "Label for y-axis"
    inputBinding:
      position: 14
      prefix: --y_label
  - id: x_min
    type:
      - 'null'
      - float
    doc: "Minimum value for x-axis"
    inputBinding:
      position: 15
      prefix: --x_min
  - id: y_min
    type:
      - 'null'
      - float
    doc: "Minimum value for y-axis"
    inputBinding:
      position: 16
      prefix: --y_min
  - id: x_max
    type:
      - 'null'
      - float
    doc: "Maximum value for x-axis"
    inputBinding:
      position: 17
      prefix: --x_max
  - id: y_max
    type:
      - 'null'
      - float
    doc: "Maximum value for y-axis"
    inputBinding:
      position: 18
      prefix: --y_max
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of canvas"
    inputBinding:
      position: 19
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of canvas"
    inputBinding:
      position: 20
      prefix: --height
  - id: intersection
    type:
      - 'null'
      - boolean
    doc: "Activate intersection mode, which plots the shared and exclusive content found in the matrix."
    inputBinding:
      position: 21
      prefix: --intersection
  - id: list
    type:
      - 'null'
      - string
    doc: "The list of columns or rows to select from the matrix (overrides intersection)"
    inputBinding:
      position: 22
      prefix: --list
  - id: exc_cutoff_d1
    type:
      - 'null'
      - int
    doc: "If in intersection mode, the level at which content for dataset 1 is considered exclusive or shared"
    inputBinding:
      position: 23
      prefix: --exc_cutoff_d1
  - id: exc_cutoff_d2
    type:
      - 'null'
      - int
    doc: "If in intersection mode, the level at which content for dataset 2 is considered exclusive or shared"
    inputBinding:
      position: 24
      prefix: --exc_cutoff_d2
  - id: x_logscale
    type:
      - 'null'
      - boolean
    doc: "X-axis is logscale. Overrides x_min and x_max"
    inputBinding:
      position: 25
      prefix: --x_logscale
  - id: y_logscale
    type:
      - 'null'
      - boolean
    doc: "Y-axis is logscale. Overrides y_min and y_max"
    inputBinding:
      position: 26
      prefix: --y_logscale
  - id: dpi
    type:
      - 'null'
      - int
    doc: "Resolution in dots per inch of output graphic."
    inputBinding:
      position: 27
      prefix: --dpi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print extra information"
    inputBinding:
      position: 28
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: "Plot file(s) written to the output path"
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kat:2.4.2--py39he0b6574_5
stdout: kat_plot_spectra-mx.out
