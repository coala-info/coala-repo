cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wally
  - matches
label: wally_matches
doc: "Display matches from BAM files\n\nTool homepage: https://github.com/tobiasrausch/wally"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: disable_node_labeling
    type:
      - 'null'
      - boolean
    doc: turn off node labeling
    inputBinding:
      position: 102
      prefix: --labeloff
  - id: font_scale
    type:
      - 'null'
      - float
    doc: font scale
    default: 0.400000006
    inputBinding:
      position: 102
      prefix: --ftscale
  - id: genome_fasta_file
    type: File
    doc: genome fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: min_matches_per_region
    type:
      - 'null'
      - int
    doc: min. number of matches per region
    default: 1
    inputBinding:
      position: 102
      prefix: --matches
  - id: min_sequence_size
    type:
      - 'null'
      - int
    doc: min. sequence size to include
    default: 0
    inputBinding:
      position: 102
      prefix: --size
  - id: plot_height
    type:
      - 'null'
      - int
    doc: 'height of the plot [0: best fit]'
    default: 0
    inputBinding:
      position: 102
      prefix: --height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: 'width of the plot [0: best fit]'
    default: 0
    inputBinding:
      position: 102
      prefix: --width
  - id: read_name
    type:
      - 'null'
      - string
    doc: read to display
    default: read_name
    inputBinding:
      position: 102
      prefix: --read
  - id: reads_file
    type:
      - 'null'
      - File
    doc: file with reads to display
    inputBinding:
      position: 102
      prefix: --rfile
  - id: separate_plots
    type:
      - 'null'
      - boolean
    doc: create one plot for each input read
    inputBinding:
      position: 102
      prefix: --separate
  - id: track_height
    type:
      - 'null'
      - int
    doc: track height in pixels
    default: 15
    inputBinding:
      position: 102
      prefix: --trackheight
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size to cluster nearby matches
    default: 10000
    inputBinding:
      position: 102
      prefix: --winsize
outputs:
  - id: sequence_output_file
    type:
      - 'null'
      - File
    doc: sequence output file [optional]
    outputBinding:
      glob: $(inputs.sequence_output_file)
  - id: plot_output_file
    type:
      - 'null'
      - File
    doc: plot output file
    outputBinding:
      glob: $(inputs.plot_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wally:0.7.1--h4d20210_1
