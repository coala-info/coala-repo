cwlVersion: v1.2
class: CommandLineTool
baseCommand: [plot-cnv]
label: neoloop_plot-cnv
doc: "Plot genome-wide CNV profiles and segments.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: cnv_profile
    type: File
    doc: Copy number profile in bedGraph format.
    inputBinding:
      position: 101
      prefix: --cnv-profile
  - id: cnv_segment
    type:
      - 'null'
      - File
    doc: Copy number segmentation in bedGraph format.
    inputBinding:
      position: 101
      prefix: --cnv-segment
  - id: output_figure_name
    type: string
    doc: Output figure file path.
    inputBinding:
      position: 101
      prefix: --output-figure-name
  - id: chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosome labels to plot; "#" stands for chromosomes with numerical labels (default # X).
    inputBinding:
      position: 101
      prefix: --chroms
  - id: dot_size
    type:
      - 'null'
      - float
    doc: Size of the dots (default 0.5).
    inputBinding:
      position: 101
      prefix: --dot-size
  - id: dot_alpha
    type:
      - 'null'
      - float
    doc: Alpha blending value of the dots, between 0 and 1 (default 0.1).
    inputBinding:
      position: 101
      prefix: --dot-alpha
  - id: line_width
    type:
      - 'null'
      - float
    doc: Width of the CNV segment lines (default 1).
    inputBinding:
      position: 101
      prefix: --line-width
  - id: boundary_width
    type:
      - 'null'
      - float
    doc: Width of the chromosome boundaries (default 1).
    inputBinding:
      position: 101
      prefix: --boundary-width
  - id: label_size
    type:
      - 'null'
      - int
    doc: Label font size (default 6).
    inputBinding:
      position: 101
      prefix: --label-size
  - id: tick_label_size
    type:
      - 'null'
      - int
    doc: Font size of the tick labels (default 3).
    inputBinding:
      position: 101
      prefix: --tick-label-size
  - id: maximum_value
    type:
      - 'null'
      - float
    doc: Maximum value of the y axis.
    inputBinding:
      position: 101
      prefix: --maximum-value
  - id: minimum_value
    type:
      - 'null'
      - float
    doc: Minimum value of the y axis.
    inputBinding:
      position: 101
      prefix: --minimum-value
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Width of the figure (default 5).
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Height of the figure (default 1).
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: Figure resolution.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: clean_mode
    type:
      - 'null'
      - boolean
    doc: Clean mode (no axes decorations).
    inputBinding:
      position: 101
      prefix: --clean-mode
outputs:
  - id: figure
    type: File
    doc: The CNV figure.
    outputBinding:
      glob: $(inputs.output_figure_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
