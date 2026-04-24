cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_segalign
label: segalign-galaxy_run_segalign
doc: "Run segalign with specified target and query files.\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs:
  - id: target
    type: File
    doc: Target sequence file
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Query sequence file
    inputBinding:
      position: 2
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: ambiguous nucleotides - n/iupac
    inputBinding:
      position: 103
      prefix: --ambiguous
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug messages
    inputBinding:
      position: 103
      prefix: --debug
  - id: format
    type:
      - 'null'
      - string
    doc: "format of output file (same formats as provided by \n                  \
      \      LASTZ) - lav, lav+text, axt, axt+, maf, maf+, maf-, \n              \
      \          sam, softsam, sam-, softsam-, cigar, BLASTN, \n                 \
      \       differences, rdotplot, text"
    inputBinding:
      position: 103
      prefix: --format
  - id: gappedthresh
    type:
      - 'null'
      - int
    doc: score threshold for gapped alignments
    inputBinding:
      position: 103
      prefix: --gappedthresh
  - id: hspthresh
    type:
      - 'null'
      - int
    doc: segment score threshold for high scoring pairs
    inputBinding:
      position: 103
      prefix: --hspthresh
  - id: lastz_interval_size
    type:
      - 'null'
      - int
    doc: "LASTZ interval for ydrop - change only \n                              \
      \          if you are a developer"
    inputBinding:
      position: 103
      prefix: --lastz_interval_size
  - id: markend
    type:
      - 'null'
      - boolean
    doc: write a marker line just before completion
    inputBinding:
      position: 103
      prefix: --markend
  - id: noentropy
    type:
      - 'null'
      - boolean
    doc: "don't adjust low score segment pair scores using \n                    \
      \      entropy factor after filtering stage"
    inputBinding:
      position: 103
      prefix: --noentropy
  - id: nogapped
    type:
      - 'null'
      - boolean
    doc: don't perform gapped extension stage
    inputBinding:
      position: 103
      prefix: --nogapped
  - id: notransition
    type:
      - 'null'
      - boolean
    doc: don't allow one transition in a seed hit
    inputBinding:
      position: 103
      prefix: --notransition
  - id: notrivial
    type:
      - 'null'
      - boolean
    doc: "Don't output a trivial self-alignment block if the \n                  \
      \      target and query sequences are identical"
    inputBinding:
      position: 103
      prefix: --notrivial
  - id: num_gpu
    type:
      - 'null'
      - int
    doc: "Specify number of GPUs to use - -1 if \n                               \
      \         all the GPUs should be used"
    inputBinding:
      position: 103
      prefix: --num_gpu
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Specify number of CPU threads to use - \n                              \
      \          -1 if all the CPU threads should be \n                          \
      \              used"
    inputBinding:
      position: 103
      prefix: --num_threads
  - id: scoring
    type:
      - 'null'
      - File
    doc: Scoring file in LASTZ format
    inputBinding:
      position: 103
      prefix: --scoring
  - id: seed
    type:
      - 'null'
      - string
    doc: "seed pattern-12of19(1110100110010101111)/14of22(1110101\n              \
      \          100110010101111)/an arbitrary pattern of 1s, 0s, and Ts"
    inputBinding:
      position: 103
      prefix: --seed
  - id: seq_block_size
    type:
      - 'null'
      - int
    doc: "LASTZ interval for ydrop - change only \n                              \
      \          if you are a developer"
    inputBinding:
      position: 103
      prefix: --seq_block_size
  - id: step
    type:
      - 'null'
      - int
    doc: "Offset between the starting positions of successive \n                 \
      \       target words considered for generating seed table"
    inputBinding:
      position: 103
      prefix: --step
  - id: strand
    type:
      - 'null'
      - string
    doc: strand to search - plus/minus/both
    inputBinding:
      position: 103
      prefix: --strand
  - id: wga_chunk_size
    type:
      - 'null'
      - int
    doc: "chunk sizes for GPU calls for Xdrop - \n                               \
      \         change only if you are a developer"
    inputBinding:
      position: 103
      prefix: --wga_chunk_size
  - id: xdrop
    type:
      - 'null'
      - int
    doc: x-drop value for gap-free extension
    inputBinding:
      position: 103
      prefix: --xdrop
  - id: ydrop
    type:
      - 'null'
      - int
    doc: y-drop value for gapped extension
    inputBinding:
      position: 103
      prefix: --ydrop
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
