cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-hover-locator.R
label: seurat-scripts_seurat-hover-locator.R
doc: 'Turn a Seurat plot (ggplot2 RDS) into an interactive HTML hover plot (Seurat HoverLocator).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: plot_rds
    type: File
    doc: FILE IN
    inputBinding:
      position: 1
      prefix: --plot-rds=
      separate: false
  - id: output_html
    type: string
    doc: HTML output file
    inputBinding:
      position: 2
      prefix: --output-html=
      separate: false
  - id: information_table
    type:
      - 'null'
      - File
    doc: Table with information for overlaying on the plot. Usually the result of calling FetchData on the original Seurat object.
    inputBinding:
      position: 3
      prefix: --information-table=
      separate: false
  - id: do_not_stringsAsFactors
    type:
      - 'null'
      - boolean
    doc: Load strings as factors.
    inputBinding:
      position: 4
      prefix: --do-not-stringsAsFactors
  - id: key
    type:
      - 'null'
      - string
    doc: Key (index) for the information table
    inputBinding:
      position: 5
      prefix: --key=
      separate: false
  - id: do_not_keepLeadingZeros
    type:
      - 'null'
      - boolean
    doc: If TRUE a column containing numeric data with leading zeros will be read as character, otherwise leading zeros will be removed and converted to numeric.
    inputBinding:
      position: 6
      prefix: --do-not-keepLeadingZeros
  - id: do_not_axes
    type:
      - 'null'
      - boolean
    doc: Display x- and y-axes
    inputBinding:
      position: 7
      prefix: --do-not-axes
  - id: dark_theme
    type:
      - 'null'
      - boolean
    doc: Plot using a dark theme?
    inputBinding:
      position: 8
      prefix: --dark-theme
  - id: do_not_selfcontained
    type:
      - 'null'
      - boolean
    doc: Whether to save the HTML as a single self-contained file (with external resources base64 encoded) or a file with external resources placed in an adjacent directory.
    inputBinding:
      position: 9
      prefix: --do-not-selfcontained
  - id: libdir
    type:
      - 'null'
      - string
    doc: Directory to copy HTML dependencies into (defaults to filename_files).
    inputBinding:
      position: 10
      prefix: --libdir=
      separate: false
outputs:
  - id: output_html
    type: File
    doc: HTML output file
    outputBinding:
      glob: $(inputs.output_html)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
