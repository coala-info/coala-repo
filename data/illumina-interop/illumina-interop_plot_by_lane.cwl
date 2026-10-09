cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_plot_by_lane
label: illumina-interop_plot_by_lane
doc: "Plot a metric by lane (gnuplot data on standard output)\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folder
    type: Directory
    doc: Path to the run folder
    inputBinding:
      position: 1
  - id: metric_name
    type:
      - 'null'
      - string
    doc: 'Metric to plot (default ClusterCount)'
    inputBinding:
      position: 102
      prefix: --metric-name=
      separate: false
  - id: filter_by_lane
    type:
      - 'null'
      - int
    doc: Only the data for the selected lane will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-lane=
      separate: false
  - id: filter_by_channel
    type:
      - 'null'
      - string
    doc: Only the data for the selected channel will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-channel=
      separate: false
  - id: filter_by_base
    type:
      - 'null'
      - string
    doc: Only the data for the selected base will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-base=
      separate: false
  - id: filter_by_surface
    type:
      - 'null'
      - int
    doc: Only the data for the selected surface will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-surface=
      separate: false
  - id: filter_by_read
    type:
      - 'null'
      - int
    doc: Only the data for the selected read will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-read=
      separate: false
  - id: filter_by_cycle
    type:
      - 'null'
      - int
    doc: Only the data for the selected cycle will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-cycle=
      separate: false
  - id: filter_by_tile_number
    type:
      - 'null'
      - int
    doc: Only the data for the selected tile number will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-tile-number=
      separate: false
  - id: filter_by_swath
    type:
      - 'null'
      - int
    doc: Only the data for the selected swath will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-swath=
      separate: false
  - id: filter_by_section
    type:
      - 'null'
      - int
    doc: Only the data for the selected section will be displayed
    inputBinding:
      position: 102
      prefix: --filter-by-section=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_plot_by_lane.out
