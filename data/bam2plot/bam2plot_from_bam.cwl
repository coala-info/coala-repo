cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2plot
label: bam2plot_from_bam
doc: "Plot your bam files!\n\nTool homepage: https://github.com/willros/bam2plot"
inputs:
  - id: sub_command
    type: string
    doc: sub_command
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: bam file
    inputBinding:
      position: 102
      prefix: --bam
  - id: cum_plot
    type:
      - 'null'
      - boolean
    doc: Generate cumulative plots of all chromosomes
    inputBinding:
      position: 102
      prefix: --cum_plot
  - id: index_bam
    type:
      - 'null'
      - boolean
    doc: Index bam file
    inputBinding:
      position: 102
      prefix: --index
  - id: no_cum_plot
    type:
      - 'null'
      - boolean
    doc: Generate cumulative plots of all chromosomes
    inputBinding:
      position: 102
      prefix: --no-cum_plot
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: Index bam file
    inputBinding:
      position: 102
      prefix: --no-index
  - id: no_sort_and_index
    type:
      - 'null'
      - boolean
    doc: Index and sort bam file
    inputBinding:
      position: 102
      prefix: --no-sort_and_index
  - id: number_of_refs
    type:
      - 'null'
      - int
    doc: How many references (chromosomes) to plot
    inputBinding:
      position: 102
      prefix: --number_of_refs
  - id: plot_type
    type:
      - 'null'
      - string
    doc: How to save the plots
    inputBinding:
      position: 102
      prefix: --plot_type
  - id: rolling_window
    type:
      - 'null'
      - int
    doc: Rolling window size
    inputBinding:
      position: 102
      prefix: --rolling_window
  - id: sort_and_index
    type:
      - 'null'
      - boolean
    doc: Index and sort bam file
    inputBinding:
      position: 102
      prefix: --sort_and_index
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold of mean coverage depth
    inputBinding:
      position: 102
      prefix: --threshold
  - id: whitelist
    type:
      - 'null'
      - string
    doc: Only include these references/chromosomes.
    inputBinding:
      position: 102
      prefix: --whitelist
  - id: zoom
    type:
      - 'null'
      - string
    doc: "Zoom into this region. Example: -z='100 2000'"
    inputBinding:
      position: 102
      prefix: --zoom
outputs:
  - id: outpath
    type: Directory
    doc: Where to save the plots.
    outputBinding:
      glob: $(inputs.outpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
