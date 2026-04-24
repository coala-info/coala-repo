cwlVersion: v1.2
class: CommandLineTool
baseCommand: spoa
label: spoa
doc: "SPoA: A Sparse-Aligner for Long Reads\n\nTool homepage: https://github.com/rvaser/spoa"
inputs:
  - id: sequences
    type: File
    doc: input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - int
    doc: 'alignment mode: 0 - local (Smith-Waterman), 1 - global (Needleman-Wunsch),
      2 - semi-global'
    inputBinding:
      position: 102
      prefix: --algorithm
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty (must be non-positive)
    inputBinding:
      position: 102
      prefix: -e
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap opening penalty (must be non-positive)
    inputBinding:
      position: 102
      prefix: -g
  - id: match_score
    type:
      - 'null'
      - int
    doc: score for matching bases
    inputBinding:
      position: 102
      prefix: -m
  - id: min_consensus_coverage
    type:
      - 'null'
      - int
    doc: minimal consensus coverage (usable only with -r 0)
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: score for mismatching bases
    inputBinding:
      position: 102
      prefix: -n
  - id: result_mode
    type:
      - 'null'
      - type: array
        items: int
    doc: 'result mode: 0 - consensus (FASTA), 1 - multiple sequence alignment (FASTA),
      2 - 0 & 1 (FASTA), 3 - partial order graph (GFA), 4 - 0 & 3 (GFA)'
    inputBinding:
      position: 102
      prefix: --result
  - id: second_gap_extend_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty of the second affine function (must be 
      non-positive)
    inputBinding:
      position: 102
      prefix: -c
  - id: second_gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap opening penalty of the second affine function (must be 
      non-positive)
    inputBinding:
      position: 102
      prefix: -q
  - id: strand_ambiguous
    type:
      - 'null'
      - boolean
    doc: for each sequence pick the strand with the better alignment
    inputBinding:
      position: 102
      prefix: --strand-ambiguous
outputs:
  - id: dot_output_file
    type:
      - 'null'
      - File
    doc: output file for the partial order graph in DOT format
    outputBinding:
      glob: $(inputs.dot_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spoa:4.1.5--h077b44d_0
