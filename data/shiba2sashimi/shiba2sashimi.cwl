cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba2sashimi
label: shiba2sashimi
doc: "Create Sashimi plot from Shiba output\n\nTool homepage: https://github.com/Sika-Zheng-Lab/shiba2sashimi"
inputs:
  - id: colors
    type:
      - 'null'
      - string
    doc: Colors for each group. e.g. red,orange,blue
    inputBinding:
      position: 101
      prefix: --colors
  - id: coordinate
    type:
      - 'null'
      - string
    doc: Coordinates of the region to plot
    inputBinding:
      position: 101
      prefix: --coordinate
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'DPI of the output figure. Default: 300'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: experiment
    type: string
    doc: Experiment table used for Shiba
    inputBinding:
      position: 101
      prefix: --experiment
  - id: extend_down
    type:
      - 'null'
      - int
    doc: 'Extend the plot downstream. Only used when not providing coordinates. Default:
      500'
    inputBinding:
      position: 101
      prefix: --extend_down
  - id: extend_up
    type:
      - 'null'
      - int
    doc: 'Extend the plot upstream. Only used when not providing coordinates. Default:
      500'
    inputBinding:
      position: 101
      prefix: --extend_up
  - id: font_family
    type:
      - 'null'
      - string
    doc: Font family for labels
    inputBinding:
      position: 101
      prefix: --font_family
  - id: groups
    type:
      - 'null'
      - string
    doc: 'Groups to plot. e.g. group1,group2,group3 Default: all groups in the experiment
      table. Overrides --samples'
    inputBinding:
      position: 101
      prefix: --groups
  - id: id
    type:
      - 'null'
      - string
    doc: Positional ID (pos_id) of the event to plot
    inputBinding:
      position: 101
      prefix: --id
  - id: minimum_junc_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads to plot a junction arc. Default: 1'
    inputBinding:
      position: 101
      prefix: --minimum_junc_reads
  - id: nojunc
    type:
      - 'null'
      - boolean
    doc: Do not plot junction arcs and junction read counts to the plot
    inputBinding:
      position: 101
      prefix: --nojunc
  - id: nolabel
    type:
      - 'null'
      - boolean
    doc: Do not add sample labels and PSI values to the plot
    inputBinding:
      position: 101
      prefix: --nolabel
  - id: samples
    type:
      - 'null'
      - string
    doc: 'Samples to plot. e.g. sample1,sample2,sample3 Default: all samples in the
      experiment table'
    inputBinding:
      position: 101
      prefix: --samples
  - id: shiba
    type: string
    doc: Shiba working directory
    inputBinding:
      position: 101
      prefix: --shiba
  - id: smoothing_window_size
    type:
      - 'null'
      - int
    doc: 'Window size for median filter to smooth coverage plot. Greater value gives
      smoother plot. Default: 21'
    inputBinding:
      position: 101
      prefix: --smoothing_window_size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: 'Width of the output figure. Default: 8'
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba2sashimi:0.1.7--pyh7e72e81_0
