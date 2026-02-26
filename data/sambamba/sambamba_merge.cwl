cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-merge
label: sambamba_merge
doc: "Merge multiple BAM files into a single BAM file.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM files to merge
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: level of compression for merged BAM file, number from 0 to 9
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: filter
    type:
      - 'null'
      - string
    doc: keep only reads that satisfy FILTER
    inputBinding:
      position: 102
      prefix: --filter
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use for compression/decompression
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: output_header_stdout
    type:
      - 'null'
      - boolean
    doc: output merged header to stdout in SAM format, other options are 
      ignored; mainly for debug purposes
    inputBinding:
      position: 102
      prefix: --header
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progress bar in STDERR
    inputBinding:
      position: 102
      prefix: --show-progress
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
