cwlVersion: v1.2
class: CommandLineTool
baseCommand: sumatra
label: sumatra
doc: "Computes all the pairwise LCS (Longest Common Subsequence) scores of one nucleotide
  dataset or between two nucleotide datasets.\n\nTool homepage: https://github.com/sumatrapdfreader/sumatrapdf"
inputs:
  - id: dataset1
    type:
      - 'null'
      - File
    doc: The nucleotide dataset to analyze (or nothing if there is only one 
      dataset and the standard input should be used).
    inputBinding:
      position: 1
  - id: dataset2
    type:
      - 'null'
      - File
    doc: Optionally the second nucleotide dataset
    inputBinding:
      position: 2
  - id: distance
    type:
      - 'null'
      - boolean
    doc: 'Score is expressed in distance (default: score is expressed in similarity).'
    default: false
    inputBinding:
      position: 103
      prefix: -d
  - id: include_counts_and_lengths
    type:
      - 'null'
      - boolean
    doc: Adds four extra columns with the count and length of both sequences.
    inputBinding:
      position: 103
      prefix: -x
  - id: normalized_by_ref_len
    type:
      - 'null'
      - boolean
    doc: Score is normalized by reference sequence length (default).
    default: true
    inputBinding:
      position: 103
      prefix: -n
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for computation
    default: 1
    inputBinding:
      position: 103
      prefix: -p
  - id: raw_score
    type:
      - 'null'
      - boolean
    doc: Raw score, not normalized.
    inputBinding:
      position: 103
      prefix: -r
  - id: ref_len_alignment
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the alignment length (default).
    default: true
    inputBinding:
      position: 103
      prefix: -a
  - id: ref_len_largest
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the largest.
    inputBinding:
      position: 103
      prefix: -L
  - id: ref_len_shortest
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the shortest.
    inputBinding:
      position: 103
      prefix: -l
  - id: replace_n_with_a
    type:
      - 'null'
      - boolean
    doc: "n's are replaced with a's (default: sequences with n's are discarded)."
    default: false
    inputBinding:
      position: 103
      prefix: -g
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: 'Score threshold. If the score is normalized and expressed in similarity
      (default), it is an identity, e.g. 0.95 for an identity of 95%. If the score
      is normalized and expressed in distance, it is (1.0 - identity), e.g. 0.05 for
      an identity of 95%. If the score is not normalized and expressed in similarity,
      it is the length of the Longest Common Subsequence. If the score is not normalized
      and expressed in distance, it is (reference length - LCS length). Only sequence
      pairs with a similarity above ##.## are printed.'
    default: 0.0
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sumatra:v1.0.31-2-deb_cv1
stdout: sumatra.out
