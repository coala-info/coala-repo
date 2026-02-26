cwlVersion: v1.2
class: CommandLineTool
baseCommand: segalign_repeat_masker
label: segalign-galaxy_run_segalign_repeat_masker
doc: "You must specify a sequence file\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs:
  - id: seq_file
    type: File
    doc: Sequence file
    inputBinding:
      position: 1
  - id: M
    type:
      - 'null'
      - int
    doc: report any position that is covered by at least this many alignments; 
      the maximum allowed depth is 255
    default: 1
    inputBinding:
      position: 102
      prefix: --M
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: ambiguous nucleotides - n/iupac
    inputBinding:
      position: 102
      prefix: --ambiguous
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug messages
    inputBinding:
      position: 102
      prefix: --debug
  - id: hspthresh
    type:
      - 'null'
      - int
    doc: segment score threshold for high scoring pairs
    default: 3000
    inputBinding:
      position: 102
      prefix: --hspthresh
  - id: lastz_interval_size
    type:
      - 'null'
      - int
    doc: LASTZ interval for ydrop - change only if you are a developer
    default: 10000000
    inputBinding:
      position: 102
      prefix: --lastz_interval_size
  - id: markend
    type:
      - 'null'
      - boolean
    doc: write a marker line just before completion
    inputBinding:
      position: 102
      prefix: --markend
  - id: neighbor_proportion
    type:
      - 'null'
      - float
    doc: proportion of neighbouring intervals to align the query interval to
    default: 0.200000003
    inputBinding:
      position: 102
      prefix: --neighbor_proportion
  - id: noentropy
    type:
      - 'null'
      - boolean
    doc: don't adjust low score segment pair scores using entropy factor after 
      filtering stage
    inputBinding:
      position: 102
      prefix: --noentropy
  - id: notransition
    type:
      - 'null'
      - boolean
    doc: don't allow one transition in a seed hit
    inputBinding:
      position: 102
      prefix: --notransition
  - id: num_gpu
    type:
      - 'null'
      - int
    doc: Specify number of GPUs to use - -1 if all the GPUs should be used
    default: -1
    inputBinding:
      position: 102
      prefix: --num_gpu
  - id: scoring
    type:
      - 'null'
      - File
    doc: Scoring file in LASTZ format
    inputBinding:
      position: 102
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - string
    doc: seed pattern-12of19(1110100110010101111)/14of22(1110101 
      100110010101111)/an arbitrary pattern of 1s, 0s, and Ts
    default: 12of19
    inputBinding:
      position: 102
      prefix: --seed
  - id: seq_block_size
    type:
      - 'null'
      - int
    doc: LASTZ interval for ydrop - change only if you are a developer
    default: 1000000000
    inputBinding:
      position: 102
      prefix: --seq_block_size
  - id: step
    type:
      - 'null'
      - int
    doc: Offset between the starting positions of successive target words 
      considered for generating seed table
    default: 1
    inputBinding:
      position: 102
      prefix: --step
  - id: strand
    type:
      - 'null'
      - string
    doc: strand to search - plus/minus/both
    default: both
    inputBinding:
      position: 102
      prefix: --strand
  - id: wga_chunk_size
    type:
      - 'null'
      - int
    doc: chunk sizes for GPU calls for Xdrop - change only if you are a 
      developer
    default: 250000
    inputBinding:
      position: 102
      prefix: --wga_chunk_size
  - id: xdrop
    type:
      - 'null'
      - int
    doc: x-drop value for gap-free extension
    default: 910
    inputBinding:
      position: 102
      prefix: --xdrop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
stdout: segalign-galaxy_run_segalign_repeat_masker.out
