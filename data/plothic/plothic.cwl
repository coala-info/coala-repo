cwlVersion: v1.2
class: CommandLineTool
baseCommand: plothic
label: plothic
doc: "Plot Whole genome Hi-C contact matrix heatmap\n\nTool homepage: https://github.com/Jwindler/PlotHiC"
inputs:
  - id: abs_bed
    type:
      - 'null'
      - File
    doc: Path to the HiCPro abs bed file
    inputBinding:
      position: 101
      prefix: --abs-bed
  - id: abs_order
    type:
      - 'null'
      - File
    doc: Path to the HiCPro abs order file
    inputBinding:
      position: 101
      prefix: --abs-order
  - id: bar_max
    type:
      - 'null'
      - float
    doc: Maximum value for color bar
    inputBinding:
      position: 101
      prefix: --bar-max
  - id: bar_min
    type:
      - 'null'
      - float
    doc: 'Minimum value for color bar, default: 0'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --bar-min
  - id: bed_split
    type:
      - 'null'
      - boolean
    doc: Plot the heatmap by split chromosome (HiCPro format)
    inputBinding:
      position: 101
      prefix: --bed-split
  - id: chr_txt
    type:
      - 'null'
      - File
    doc: Path to the chromosome text file
    inputBinding:
      position: 101
      prefix: --chr-txt
  - id: cmap
    type:
      - 'null'
      - string
    doc: 'Color map for the heatmap, default: YlOrRd'
    default: YlOrRd
    inputBinding:
      position: 101
      prefix: -cmap
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Data type for Hi-C data or "oe" (observed/expected), default: observed'
    default: observed
    inputBinding:
      position: 101
      prefix: --data-type
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'DPI for the output figure, default: 300'
    default: 300
    inputBinding:
      position: 101
      prefix: -dpi
  - id: fig_size
    type:
      - 'null'
      - float
    doc: 'Figure size, default: 10'
    default: 10.0
    inputBinding:
      position: 101
      prefix: --fig-size
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format for the figure, default: pdf'
    default: pdf
    inputBinding:
      position: 101
      prefix: -format
  - id: genome_name
    type:
      - 'null'
      - string
    doc: Genome name for the heatmap
    inputBinding:
      position: 101
      prefix: --genome-name
  - id: grid
    type:
      - 'null'
      - boolean
    doc: 'Show grid in the heatmap, Default: True'
    default: true
    inputBinding:
      position: 101
      prefix: -grid
  - id: hic_file
    type:
      - 'null'
      - File
    doc: Path to the Hi-C file
    inputBinding:
      position: 101
      prefix: --hic-file
  - id: hic_split
    type:
      - 'null'
      - string
    doc: Plot the heatmap by split chromosome (hic format)
    inputBinding:
      position: 101
      prefix: --hic-split
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: Log2 transform the data
    inputBinding:
      position: 101
      prefix: -log
  - id: matrix
    type:
      - 'null'
      - File
    doc: Path to the HiCPro matrix file
    inputBinding:
      position: 101
      prefix: -matrix
  - id: normalization
    type:
      - 'null'
      - string
    doc: 'Normalization method for Hi-C data (NONE, VC, VC_SQRT, KR, SCALE, etc.),
      default: NONE'
    default: NONE
    inputBinding:
      position: 101
      prefix: --normalization
  - id: order
    type:
      - 'null'
      - boolean
    doc: 'Order the heatmap by specific order, for hic format, default: False'
    default: false
    inputBinding:
      position: 101
      prefix: -order
  - id: output
    type:
      - 'null'
      - Directory
    doc: 'Output directory, default: ./'
    default: ./
    inputBinding:
      position: 101
      prefix: --output
  - id: resolution
    type:
      - 'null'
      - int
    doc: Resolution for Hi-C data
    inputBinding:
      position: 101
      prefix: --resolution
  - id: rotation
    type:
      - 'null'
      - int
    doc: 'Rotation for the x and y axis labels, default: 45'
    default: 45
    inputBinding:
      position: 101
      prefix: -rotation
  - id: x_axis
    type:
      - 'null'
      - boolean
    doc: 'Show genome size at x-axis, Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --x-axis
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plothic:1.0.0--pyh5707d69_0
stdout: plothic.out
