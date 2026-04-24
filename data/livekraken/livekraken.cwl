cwlVersion: v1.2
class: CommandLineTool
baseCommand: livekraken
label: livekraken
doc: "Need to specify input filenames!\n\nTool homepage: https://gitlab.com/SimonHTausch/LiveKraken"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input filename(s)
    inputBinding:
      position: 1
  - id: bcl_input
    type:
      - 'null'
      - boolean
    doc: Input is BCL format
    inputBinding:
      position: 102
      prefix: --bcl-input
  - id: bcl_lanes
    type:
      - 'null'
      - type: array
        items: int
    doc: The lanes to analyse (e.g. 1 3 4)
    inputBinding:
      position: 102
      prefix: --bcl-lanes
  - id: bcl_length
    type:
      - 'null'
      - int
    doc: Number of sequencing cycles
    inputBinding:
      position: 102
      prefix: --bcl-length
  - id: bcl_max_tile
    type:
      - 'null'
      - int
    doc: Maximum tile to analyse, in XYZZ tile format.
    inputBinding:
      position: 102
      prefix: --bcl-max-tile
  - id: bcl_spacing
    type:
      - 'null'
      - int
    doc: Spacing between classification
    inputBinding:
      position: 102
      prefix: --bcl-spacing
  - id: bcl_start
    type:
      - 'null'
      - int
    doc: First analysis cycle (>31)
    inputBinding:
      position: 102
      prefix: --bcl-start
  - id: bcl_tiles
    type:
      - 'null'
      - type: array
        items: int
    doc: The tiles to analyse (e.g. 1101 2115 2304)
    inputBinding:
      position: 102
      prefix: --bcl-tiles
  - id: bzip2_compressed
    type:
      - 'null'
      - boolean
    doc: Input is bzip2 compressed
    inputBinding:
      position: 102
      prefix: --bzip2-compressed
  - id: check_names
    type:
      - 'null'
      - boolean
    doc: Ensure each pair of reads have names that agree with each other; 
      ignored if --paired is not specified
    inputBinding:
      position: 102
      prefix: --check-names
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name for Kraken DB
    inputBinding:
      position: 102
      prefix: --db
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTA format
    inputBinding:
      position: 102
      prefix: --fasta-input
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq-input
  - id: gzip_compressed
    type:
      - 'null'
      - boolean
    doc: Input is gzip compressed
    inputBinding:
      position: 102
      prefix: --gzip-compressed
  - id: min_hits
    type:
      - 'null'
      - int
    doc: In quick op., number of hits req'd for classification
    inputBinding:
      position: 102
      prefix: --min-hits
  - id: only_classified_output
    type:
      - 'null'
      - boolean
    doc: Print no Kraken output for unclassified sequences
    inputBinding:
      position: 102
      prefix: --only-classified-output
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The two filenames provided are paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
  - id: preload
    type:
      - 'null'
      - boolean
    doc: Loads DB into memory before classification
    inputBinding:
      position: 102
      prefix: --preload
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick operation (use first hit or hits)
    inputBinding:
      position: 102
      prefix: --quick
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: unclassified_out
    type:
      - 'null'
      - File
    doc: Print unclassified sequences to filename
    outputBinding:
      glob: $(inputs.unclassified_out)
  - id: classified_out
    type:
      - 'null'
      - File
    doc: Print classified sequences to filename
    outputBinding:
      glob: $(inputs.classified_out)
  - id: output
    type:
      - 'null'
      - File
    doc: 'Print output to filename (default: stdout); "-" will suppress normal output'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12
