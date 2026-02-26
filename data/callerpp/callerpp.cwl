cwlVersion: v1.2
class: CommandLineTool
baseCommand: callerpp
label: callerpp
doc: "A tool for consensus calling and multiple sequence alignment.\n\nTool homepage:
  https://github.com/nh13/callerpp"
inputs:
  - id: sequences
    type: string
    doc: "The input will be read from standard input. Each batch of\n       input
      sequences should start with a FASTA header line ('>').\n       Each sequence
      in the batch should be on its own line thereafter."
    inputBinding:
      position: 1
  - id: alignment_algorithm
    type:
      - 'null'
      - int
    doc: "The type of alignment to perform\n                             0 - local
      (Smith-Waterman\n                             1 - global (Needleman-Wunsch)\n\
      \                             2 - semi-global (glocal)"
    default: 0
    inputBinding:
      position: 102
      prefix: --algorithm
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: The penalty for a gap
    default: -8
    inputBinding:
      position: 102
      prefix: --gap
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read from this input file, stdin otherwise
    default: stdin
    inputBinding:
      position: 102
      prefix: --input
  - id: left_align_msa
    type:
      - 'null'
      - boolean
    doc: Left align the sequences in the multiple sequence alignment
    default: false
    inputBinding:
      position: 102
      prefix: --left-align
  - id: match_score
    type:
      - 'null'
      - int
    doc: The score for a sequence match
    default: 5
    inputBinding:
      position: 102
      prefix: --match
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: The penalty for a sequence mismatch
    default: -4
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: output_coverage
    type:
      - 'null'
      - boolean
    doc: Output the per-base coverage for the consensus
    default: false
    inputBinding:
      position: 102
      prefix: --coverage
  - id: output_msa
    type:
      - 'null'
      - boolean
    doc: Output multiple sequence alignment
    default: false
    inputBinding:
      position: 102
      prefix: --msa
  - id: pairwise_msa
    type:
      - 'null'
      - boolean
    doc: Re-compute the MSA by adding in the consensus first
    default: false
    inputBinding:
      position: 102
      prefix: --pairwise-msa
  - id: resort_input
    type:
      - 'null'
      - int
    doc: "Resort the input sequences prior to POA/MSA\n                          \
      \   0 - do not sort\n                             1 - by length sequence (shortest
      first)\n                             2 - by length sequence (longest first)"
    default: 0
    inputBinding:
      position: 102
      prefix: --resort
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callerpp:0.1.6--h503566f_2
stdout: callerpp.out
