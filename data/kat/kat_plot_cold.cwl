cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kat
  - plot
  - cold
label: kat_plot_cold
doc: "Creates a scatter plot of median read k-mer coverage vs GC% for each assembly contig, from the stats file of kat cold.\n\nTool homepage: https://github.com/TGAC/KAT"
inputs:
  - id: stats_file
    type: File
    doc: "The stats file produced by kat cold"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: kat-plot-cold.png
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
  - id: y_max
    type:
      - 'null'
      - float
    doc: "Maximum value for y-axis"
    inputBinding:
      position: 13
      prefix: --y_max
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of canvas"
    inputBinding:
      position: 14
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of canvas"
    inputBinding:
      position: 15
      prefix: --height
  - id: dpi
    type:
      - 'null'
      - int
    doc: "Resolution in dots per inch of output graphic."
    inputBinding:
      position: 16
      prefix: --dpi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print extra information"
    inputBinding:
      position: 17
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
stdout: kat_plot_cold.out
