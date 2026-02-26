cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wally
  - dotplot
label: wally_dotplot
doc: "Generates dot plots for sequence alignment visualization.\n\nTool homepage:
  https://github.com/tobiasrausch/wally"
inputs:
  - id: sample_bam
    type: File
    doc: Sample BAM file (in BAM mode)
    inputBinding:
      position: 1
  - id: sample_fa
    type: File
    doc: Sample FASTA file (in FASTA mode)
    inputBinding:
      position: 2
  - id: flatten_mapping_segments
    type:
      - 'null'
      - boolean
    doc: Flatten mapping segments
    inputBinding:
      position: 103
      prefix: --flatten
  - id: flip_axes
    type:
      - 'null'
      - boolean
    doc: Flip x and y-axis
    inputBinding:
      position: 103
      prefix: --flip
  - id: genome_fasta
    type: File
    doc: Genome FASTA file
    inputBinding:
      position: 103
      prefix: --genome
  - id: include_self_alignments
    type:
      - 'null'
      - boolean
    doc: Include self alignments
    inputBinding:
      position: 103
      prefix: --selfalign
  - id: line_width
    type:
      - 'null'
      - float
    doc: Match line width
    default: 1.5
    inputBinding:
      position: 103
      prefix: --linewidth
  - id: match_length
    type:
      - 'null'
      - int
    doc: Default match length
    default: 11
    inputBinding:
      position: 103
      prefix: --matchlen
  - id: min_sequence_size
    type:
      - 'null'
      - int
    doc: Minimum sequence size to include
    default: 0
    inputBinding:
      position: 103
      prefix: --size
  - id: plot_height
    type:
      - 'null'
      - int
    doc: 'Height of the plot [0: best fit]'
    default: 0
    inputBinding:
      position: 103
      prefix: --height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: 'Width of the plot [0: best fit]'
    default: 0
    inputBinding:
      position: 103
      prefix: --width
  - id: read_to_display
    type:
      - 'null'
      - string
    doc: Read to display
    inputBinding:
      position: 103
      prefix: --read
  - id: reads_list_file
    type: File
    doc: File with reads to display
    inputBinding:
      position: 103
      prefix: --rfile
  - id: region
    type:
      - 'null'
      - string
    doc: Region to display [chrA:35-78]
    inputBinding:
      position: 103
      prefix: --region
  - id: region_list_file
    type:
      - 'null'
      - File
    doc: BED file with regions to display
    inputBinding:
      position: 103
      prefix: --reglist
outputs:
  - id: sequence_output_file
    type:
      - 'null'
      - File
    doc: Sequence output file [optional]
    outputBinding:
      glob: $(inputs.sequence_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wally:0.7.1--h4d20210_1
