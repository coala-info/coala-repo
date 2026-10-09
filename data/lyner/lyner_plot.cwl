cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_plot
doc: "Visualize current selection in different ways, depending on context.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX plot`.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging (global lyner option -v, written to standard error)"
    inputBinding:
      position: 0
      prefix: -v
  - id: matrix
    type: File
    doc: "Abundance or count matrix in tsv format (first column: feature names; other columns: samples), read with `lyner read`"
    inputBinding:
      position: 2
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Output file name; the extension (html, svg, png, json) selects the format (default lyner.html)"
    inputBinding:
      position: 20
      prefix: --outfile
  - id: directory
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 20
      prefix: --directory
  - id: with_annotation
    type:
      - 'null'
      - boolean
    doc: "Add annotation bar (needs `read-annotation`)"
    inputBinding:
      position: 20
      prefix: --with-annotation
  - id: annotation_split
    type:
      - 'null'
      - float
    doc: "Share of the figure used by the annotation, 0 to 1 (default 0.4)"
    inputBinding:
      position: 20
      prefix: --annotation-split
  - id: colorscale
    type:
      - 'null'
      - string
    doc: "Colour scale, for example RdBu, Greys, Viridis (default RdBu)"
    inputBinding:
      position: 20
      prefix: --colorscale
  - id: mode
    type:
      - 'null'
      - string
    doc: "Comma separated plot types: heatmap, scatter, lines, bar, dendrogram, histogram (default heatmap)"
    inputBinding:
      position: 20
      prefix: --mode
  - id: mode_config
    type:
      - 'null'
      - string
    doc: "Extra plot parameters as key=value pairs separated by commas"
    inputBinding:
      position: 20
      prefix: --mode-config
  - id: auto_open
    type:
      - 'null'
      - boolean
    doc: "Open the figure in a browser"
    inputBinding:
      position: 20
      prefix: --auto-open
outputs:
  - id: plot_files
    type:
      - type: array
        items: File
    doc: Figure files written by plot
    outputBinding:
      glob: "$(inputs.directory ? [inputs.directory + '/*'] : ['*.html', '*.svg', '*.png', '*.json'])"
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: plot
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_plot.out
