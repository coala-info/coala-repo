cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxalign-rs
label: maxalign-rs
doc: "A Rust reimplementation of the MaxAlign algorithm for optimizing multiple sequence\n\
  alignments by maximizing the alignment area\n\nTool homepage: https://github.com/apcamargo/maxalign-rs"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input FASTA file
    default: '-'
    inputBinding:
      position: 1
  - id: excluded_seqs_threshold
    type:
      - 'null'
      - float
    doc: Stop iterating if the fraction of excluded sequences is above this 
      threshold
    default: 1.0
    inputBinding:
      position: 102
      prefix: --excluded-seqs-threshold
  - id: heuristic_method
    type:
      - 'null'
      - string
    doc: 'Heuristic method: 1 (no synergy), 2 (pairwise synergy), 3 (three-way synergy)'
    default: '2'
    inputBinding:
      position: 102
      prefix: --heuristic-method
  - id: improvement_threshold
    type:
      - 'null'
      - float
    doc: Stop iterating if the relative improvement is below this threshold
    default: 0.0
    inputBinding:
      position: 102
      prefix: --improvement-threshold
  - id: keep_sequence
    type:
      - 'null'
      - type: array
        items: string
    doc: Sequence to always retain (can be specified multiple times)
    inputBinding:
      position: 102
      prefix: --keep-sequence
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations (-1 for unlimited iterations)
    default: -1
    inputBinding:
      position: 102
      prefix: --max-iterations
  - id: refinement
    type:
      - 'null'
      - boolean
    doc: Perform refinement using the optimal branch-and-bound algorithm
    inputBinding:
      position: 102
      prefix: --refinement
  - id: report
    type:
      - 'null'
      - File
    doc: Report file path
    inputBinding:
      position: 102
      prefix: --report
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity level (-v for normal logging, -vv for detailed logging)
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
  - id: retained_sequences
    type:
      - 'null'
      - File
    doc: Write a list of retained sequences to file
    outputBinding:
      glob: $(inputs.retained_sequences)
  - id: excluded_sequences
    type:
      - 'null'
      - File
    doc: Write a list of excluded sequences to file
    outputBinding:
      glob: $(inputs.excluded_sequences)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxalign-rs:0.1.0--h4349ce8_0
