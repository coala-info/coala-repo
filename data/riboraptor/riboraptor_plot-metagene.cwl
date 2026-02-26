cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - plot-metagene
label: riboraptor_plot-metagene
doc: "Plot metagene read counts.\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files (e.g. .counts.tsv)
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: log_scale
    type:
      - 'null'
      - boolean
    doc: Use log scale for Y-axis.
    inputBinding:
      position: 102
      prefix: --log-scale
  - id: max_value
    type:
      - 'null'
      - float
    doc: Maximum value to display on Y-axis.
    inputBinding:
      position: 102
      prefix: --max-value
  - id: min_value
    type:
      - 'null'
      - float
    doc: Minimum value to display on Y-axis.
    inputBinding:
      position: 102
      prefix: --min-value
  - id: no_legend
    type:
      - 'null'
      - boolean
    doc: Do not display legend.
    inputBinding:
      position: 102
      prefix: --no-legend
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize counts by total read counts.
    inputBinding:
      position: 102
      prefix: --normalize
  - id: smooth
    type:
      - 'null'
      - int
    doc: Smooth the curve using a moving average window of size INT.
    inputBinding:
      position: 102
      prefix: --smooth
  - id: title
    type:
      - 'null'
      - string
    doc: Plot title.
    inputBinding:
      position: 102
      prefix: --title
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Window size for smoothing (default: 50).'
    inputBinding:
      position: 102
      prefix: --window-size
  - id: xlabel
    type:
      - 'null'
      - string
    doc: X-axis label.
    inputBinding:
      position: 102
      prefix: --xlabel
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Y-axis label.
    inputBinding:
      position: 102
      prefix: --ylabel
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. If not specified, will be derived from input file 
      names.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
