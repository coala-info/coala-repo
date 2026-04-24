cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakinator
label: breakinator
doc: "Flag foldbacks and chimeric reads from SAM/BAM/CRAM or PAF input\n\nTool homepage:
  https://github.com/jheinz27/breakinator"
inputs:
  - id: chim
    type:
      - 'null'
      - int
    doc: Minimum distance to be considered chimeric
    inputBinding:
      position: 101
      prefix: --chim
  - id: fold
    type:
      - 'null'
      - int
    doc: Max distance to be considered foldback
    inputBinding:
      position: 101
      prefix: --fold
  - id: genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA used (must be provided for CRAM input
    inputBinding:
      position: 101
      prefix: --genome
  - id: input
    type: File
    doc: SAM/BAM/CRAM file sorted by read IDs
    inputBinding:
      position: 101
      prefix: --input
  - id: margin
    type:
      - 'null'
      - float
    doc: '[0-1], Proportion from center of read on either side to be considered sym
      foldback artifact'
    inputBinding:
      position: 101
      prefix: --margin
  - id: min_map_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (bps)
    inputBinding:
      position: 101
      prefix: --min-map-len
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: no_sym
    type:
      - 'null'
      - boolean
    doc: Report all foldback reads, not just those with breakpoint within margin
      of middle of read
    inputBinding:
      position: 101
      prefix: --no-sym
  - id: paf
    type:
      - 'null'
      - boolean
    doc: Input file is PAF
    inputBinding:
      position: 101
      prefix: --paf
  - id: rcoord
    type:
      - 'null'
      - boolean
    doc: Print read coordinates of breakpoint in output
    inputBinding:
      position: 101
      prefix: --rcoord
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: Print a TSV table instead of the default report (useful if evaluating 
      multiple samples)
    inputBinding:
      position: 101
      prefix: --tabular
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BAM/CRAM I/O
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakinator:1.1.1--h067a5f5_1
