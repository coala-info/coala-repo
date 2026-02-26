cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep_visualize
label: tadrep_visualize
doc: "Visualize TaDReP results\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: arrow_shaft_ratio
    type:
      - 'null'
      - float
    doc: Size ratio between arrow head and shaft
    default: 0.5
    inputBinding:
      position: 101
      prefix: --arrow-shaft-ratio
  - id: interval_start
    type:
      - 'null'
      - int
    doc: Percentage where gradient should stop
    default: 80%
    inputBinding:
      position: 101
      prefix: --interval-start
  - id: label_color
    type:
      - 'null'
      - string
    doc: Contig label color
    default: black
    inputBinding:
      position: 101
      prefix: --label-color
  - id: label_ha
    type:
      - 'null'
      - string
    doc: Contig label horizontal alignment
    default: left
    inputBinding:
      position: 101
      prefix: --label-ha
  - id: label_hpos
    type:
      - 'null'
      - string
    doc: Contig label horizontal position
    default: center
    inputBinding:
      position: 101
      prefix: --label-hpos
  - id: label_rotation
    type:
      - 'null'
      - int
    doc: Contig label rotation
    default: 45
    inputBinding:
      position: 101
      prefix: --label-rotation
  - id: label_size
    type:
      - 'null'
      - int
    doc: Contig label size
    default: 15
    inputBinding:
      position: 101
      prefix: --label-size
  - id: line_width
    type:
      - 'null'
      - float
    doc: Contig edge linewidth
    default: 0
    inputBinding:
      position: 101
      prefix: --line-width
  - id: number_of_intervals
    type:
      - 'null'
      - int
    doc: Number of gradient intervals
    default: 10
    inputBinding:
      position: 101
      prefix: --number-of-intervals
  - id: omit_ratio
    type:
      - 'null'
      - int
    doc: Omit contigs shorter than X percent of plasmid length from plot
    default: 1%
    inputBinding:
      position: 101
      prefix: --omit-ratio
  - id: plot_style
    type:
      - 'null'
      - string
    doc: Contig representation in plot
    default: box
    inputBinding:
      position: 101
      prefix: --plot-style
  - id: size_ratio
    type:
      - 'null'
      - float
    doc: Contig size ratio to track
    default: 1.0
    inputBinding:
      position: 101
      prefix: --size-ratio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_visualize.out
