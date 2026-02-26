cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtk
  - plot
label: blobtk_plot
doc: "Process a BlobDir and produce static plots.\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: blobdir
    type: Directory
    doc: Path to BlobDir directory
    inputBinding:
      position: 101
      prefix: --blobdir
  - id: busco_numbers
    type:
      - 'null'
      - boolean
    doc: '[experimental] Flag to show busco numbers instead of percentages in snail
      plot legend'
    inputBinding:
      position: 101
      prefix: --busco-numbers
  - id: cat_count
    type:
      - 'null'
      - int
    doc: Maximum number of categories for blob/cumulative plot
    default: 10
    inputBinding:
      position: 101
      prefix: --cat-count
  - id: cat_order
    type:
      - 'null'
      - string
    doc: Category order for blob/cumulative plot (<cat1>,<cat2>,...)
    inputBinding:
      position: 101
      prefix: --cat-order
  - id: category_field
    type:
      - 'null'
      - string
    doc: Category field for blob plot
    inputBinding:
      position: 101
      prefix: --category
  - id: color
    type:
      - 'null'
      - string
    doc: Individual colours to modify palette (<index>=<hexcode>)
    inputBinding:
      position: 101
      prefix: --color
  - id: decimal_precision
    type:
      - 'null'
      - int
    doc: '[experimental] Decimal precision (number of decimal places) to use when
      percentages for display'
    default: 2
    inputBinding:
      position: 101
      prefix: --decimal-precision
  - id: filter
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --filter
  - id: hist_height
    type:
      - 'null'
      - int
    doc: Maximum histogram height for blob plot
    inputBinding:
      position: 101
      prefix: --hist-height
  - id: max_scaffold
    type:
      - 'null'
      - int
    doc: max scaffold length for snail plot
    inputBinding:
      position: 101
      prefix: --max-scaffold
  - id: max_span
    type:
      - 'null'
      - int
    doc: Max span for snail plot
    inputBinding:
      position: 101
      prefix: --max-span
  - id: origin
    type:
      - 'null'
      - string
    doc: Origin for category lines in cumulative plot
    inputBinding:
      position: 101
      prefix: --origin
  - id: palette
    type:
      - 'null'
      - string
    doc: Colour palette for categories
    inputBinding:
      position: 101
      prefix: --palette
  - id: reducer_function
    type:
      - 'null'
      - string
    doc: Reducer function for blob plot
    default: sum
    inputBinding:
      position: 101
      prefix: --reducer-function
  - id: resolution
    type:
      - 'null'
      - int
    doc: Resolution for blob plot
    default: 30
    inputBinding:
      position: 101
      prefix: --resolution
  - id: rounding
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --rounding
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: Scale factor for blob plot (0.2 - 5.0)
    default: 1
    inputBinding:
      position: 101
      prefix: --scale-factor
  - id: scale_function
    type:
      - 'null'
      - string
    doc: Scale function for blob/snail plot
    default: sqrt
    inputBinding:
      position: 101
      prefix: --scale-function
  - id: segments
    type:
      - 'null'
      - int
    doc: Segment count for snail plot
    default: 1000
    inputBinding:
      position: 101
      prefix: --segments
  - id: shape
    type:
      - 'null'
      - string
    doc: Plot shape for blob plot
    inputBinding:
      position: 101
      prefix: --shape
  - id: show_legend
    type:
      - 'null'
      - string
    doc: Maximum number of categories for blob/cumulative plot
    default: default
    inputBinding:
      position: 101
      prefix: --legend
  - id: show_numbers
    type:
      - 'null'
      - boolean
    doc: '[experimental] Flag to show numbers instead of percentages in snail plot
      legend'
    inputBinding:
      position: 101
      prefix: --show-numbers
  - id: significant_digits
    type:
      - 'null'
      - int
    doc: '[experimental] Significant digits to use when rounding numbers for display'
    default: 3
    inputBinding:
      position: 101
      prefix: --significant-digits
  - id: synonym_field
    type:
      - 'null'
      - string
    doc: Field to use for sequence identifier synonyms
    inputBinding:
      position: 101
      prefix: --synonyms
  - id: view
    type: string
    doc: View to plot
    inputBinding:
      position: 101
      prefix: --view
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for grid shape plot
    inputBinding:
      position: 101
      prefix: --window-size
  - id: x_field
    type:
      - 'null'
      - string
    doc: X-axis field for blob plot
    inputBinding:
      position: 101
      prefix: --x-field
  - id: x_limit
    type:
      - 'null'
      - string
    doc: X-axis limits for blob/cumulative plot (<min>,<max>)
    inputBinding:
      position: 101
      prefix: --x-limit
  - id: y_field
    type:
      - 'null'
      - string
    doc: Y-axis field for blob plot
    inputBinding:
      position: 101
      prefix: --y-field
  - id: y_limit
    type:
      - 'null'
      - string
    doc: Y-axis limits for blob/cumulative plot (<min>,<max>)
    inputBinding:
      position: 101
      prefix: --y-limit
  - id: z_field
    type:
      - 'null'
      - string
    doc: Z-axis field for blob plot
    inputBinding:
      position: 101
      prefix: --z-field
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
