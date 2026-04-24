cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - plot-read-length
label: riboraptor_plot-read-length
doc: "Plot read length distribution\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: input_file
    type: File
    doc: Input file (e.g. .tsv, .csv, .txt)
    inputBinding:
      position: 1
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Print ASCII plot to stdout
    inputBinding:
      position: 102
      prefix: --ascii
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins for histogram
    inputBinding:
      position: 102
      prefix: --bins
  - id: column
    type:
      - 'null'
      - string
    doc: Column name to use for read lengths
    inputBinding:
      position: 102
      prefix: --column
  - id: log_scale
    type:
      - 'null'
      - boolean
    doc: Use log scale for y-axis
    inputBinding:
      position: 102
      prefix: --log-scale
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum read length to consider
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length to consider
    inputBinding:
      position: 102
      prefix: --min-length
  - id: title
    type:
      - 'null'
      - string
    doc: Plot title
    inputBinding:
      position: 102
      prefix: --title
  - id: xlabel
    type:
      - 'null'
      - string
    doc: X-axis label
    inputBinding:
      position: 102
      prefix: --xlabel
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Y-axis label
    inputBinding:
      position: 102
      prefix: --ylabel
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name (e.g. .png, .svg, .pdf)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
