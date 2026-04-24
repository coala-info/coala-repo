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
    inputBinding:
      position: 102
      prefix: --algorithm
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: The penalty for a gap
    inputBinding:
      position: 102
      prefix: --gap
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read from this input file, stdin otherwise
    inputBinding:
      position: 102
      prefix: --input
  - id: left_align_msa
    type:
      - 'null'
      - boolean
    doc: Left align the sequences in the multiple sequence alignment
    inputBinding:
      position: 102
      prefix: --left-align
  - id: match_score
    type:
      - 'null'
      - int
    doc: The score for a sequence match
    inputBinding:
      position: 102
      prefix: --match
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: The penalty for a sequence mismatch
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: output_coverage
    type:
      - 'null'
      - boolean
    doc: Output the per-base coverage for the consensus
    inputBinding:
      position: 102
      prefix: --coverage
  - id: output_msa
    type:
      - 'null'
      - boolean
    doc: Output multiple sequence alignment
    inputBinding:
      position: 102
      prefix: --msa
  - id: pairwise_msa
    type:
      - 'null'
      - boolean
    doc: Re-compute the MSA by adding in the consensus first
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
