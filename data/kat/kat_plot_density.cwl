cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kat
  - plot
  - density
label: kat_plot_density
doc: "Create K-mer Density Plots from a matrix produced by kat comp or kat gcp.\n\nTool homepage: https://github.com/TGAC/KAT"
inputs:
  - id: matrix_file
    type: File
    doc: "The input matrix file from KAT"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: kat-plot-density.png
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
  - id: z_label
    type:
      - 'null'
      - string
    doc: "Label for z-axis"
    inputBinding:
      position: 15
      prefix: --z_label
  - id: x_max
    type:
      - 'null'
      - float
    doc: "Maximum value for x-axis"
    inputBinding:
      position: 16
      prefix: --x_max
  - id: y_max
    type:
      - 'null'
      - float
    doc: "Maximum value for y-axis"
    inputBinding:
      position: 17
      prefix: --y_max
  - id: z_max
    type:
      - 'null'
      - float
    doc: "Maximum value for z-axis"
    inputBinding:
      position: 18
      prefix: --z_max
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
  - id: contours
    type:
      - 'null'
      - string
    doc: "Contour style: none, normal or smooth"
    inputBinding:
      position: 21
      prefix: --contours
  - id: not_rasterised
    type:
      - 'null'
      - boolean
    doc: "Don't rasterise graphics (slower)."
    inputBinding:
      position: 22
      prefix: --not_rasterised
  - id: dpi
    type:
      - 'null'
      - int
    doc: "Resolution in dots per inch of output graphic."
    inputBinding:
      position: 23
      prefix: --dpi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print extra information"
    inputBinding:
      position: 24
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
stdout: kat_plot_density.out
