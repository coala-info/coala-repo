cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_visualize
doc: "Visualize TaDReP results\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory to store blast hits
    inputBinding:
      position: 3
      prefix: --tmp-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default = None)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: state_dir
    type:
      - 'null'
      - Directory
    doc: Output directory of a previous TaDReP step (database, extract, characterize, cluster, detect), which is staged writable and used as the working directory
  - id: arrow_shaft_ratio
    type:
      - 'null'
      - float
    doc: Size ratio between arrow head and shaft
    inputBinding:
      position: 101
      prefix: --arrow-shaft-ratio
  - id: interval_start
    type:
      - 'null'
      - int
    doc: Percentage where gradient should stop
    inputBinding:
      position: 101
      prefix: --interval-start
  - id: label_color
    type:
      - 'null'
      - string
    doc: Contig label color
    inputBinding:
      position: 101
      prefix: --label-color
  - id: label_ha
    type:
      - 'null'
      - string
    doc: Contig label horizontal alignment
    inputBinding:
      position: 101
      prefix: --label-ha
  - id: label_hpos
    type:
      - 'null'
      - string
    doc: Contig label horizontal position
    inputBinding:
      position: 101
      prefix: --label-hpos
  - id: label_rotation
    type:
      - 'null'
      - int
    doc: Contig label rotation
    inputBinding:
      position: 101
      prefix: --label-rotation
  - id: label_size
    type:
      - 'null'
      - int
    doc: Contig label size
    inputBinding:
      position: 101
      prefix: --label-size
  - id: line_width
    type:
      - 'null'
      - float
    doc: Contig edge linewidth
    inputBinding:
      position: 101
      prefix: --line-width
  - id: number_of_intervals
    type:
      - 'null'
      - int
    doc: Number of gradient intervals
    inputBinding:
      position: 101
      prefix: --number-of-intervals
  - id: omit_ratio
    type:
      - 'null'
      - int
    doc: Omit contigs shorter than X percent of plasmid length from plot
    inputBinding:
      position: 101
      prefix: --omit-ratio
  - id: plot_style
    type:
      - 'null'
      - string
    doc: Contig representation in plot
    inputBinding:
      position: 101
      prefix: --plot-style
  - id: size_ratio
    type:
      - 'null'
      - float
    doc: Contig size ratio to track
    inputBinding:
      position: 101
      prefix: --size-ratio
outputs:
  - id: tadrep_out
    type: Directory
    doc: TaDReP output directory (working directory for the next step)
    outputBinding:
      glob: tadrep_out
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 5
    prefix: --output
    valueFrom: tadrep_out
  - position: 10
    valueFrom: visualize
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_visualize.out
