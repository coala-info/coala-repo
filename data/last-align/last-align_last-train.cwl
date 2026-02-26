cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-train
label: last-align_last-train
doc: "Try to find suitable score parameters for aligning the given sequences.\n\n\
  Tool homepage: https://gitlab.com/mcfrith/last"
inputs:
  - id: lastdb_name
    type: string
    doc: lastdb-name
    inputBinding:
      position: 1
  - id: sequence_files
    type:
      type: array
      items: File
    doc: sequence-file(s)
    inputBinding:
      position: 2
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: 'type of alignment: 0=local, 1=overlap'
    default: 0
    inputBinding:
      position: 103
      prefix: -T
  - id: gap_existence_cost
    type:
      - 'null'
      - float
    doc: gap existence cost
    default: 21 if Q>0, else 15
    inputBinding:
      position: 103
      prefix: -a
  - id: gap_extension_cost
    type:
      - 'null'
      - float
    doc: gap extension cost
    default: 9 if Q>0, else 3
    inputBinding:
      position: 103
      prefix: -b
  - id: gapsym
    type:
      - 'null'
      - boolean
    doc: force insertion/deletion symmetry
    inputBinding:
      position: 103
      prefix: --gapsym
  - id: initial_matches_step
    type:
      - 'null'
      - int
    doc: use initial matches starting at every STEP-th position in each query
    default: 1
    inputBinding:
      position: 103
      prefix: -k
  - id: input_format
    type:
      - 'null'
      - int
    doc: 'input format: 0=fasta or fastq-ignore, 1=fastq-sanger'
    default: 0
    inputBinding:
      position: 103
      prefix: -Q
  - id: insertion_existence_cost
    type:
      - 'null'
      - float
    doc: insertion existence cost
    inputBinding:
      position: 103
      prefix: -A
  - id: insertion_extension_cost
    type:
      - 'null'
      - float
    doc: insertion extension cost
    inputBinding:
      position: 103
      prefix: -B
  - id: match_mismatch_matrix
    type:
      - 'null'
      - string
    doc: match/mismatch score matrix
    inputBinding:
      position: 103
      prefix: -p
  - id: match_score
    type:
      - 'null'
      - float
    doc: match score
    default: 6 if Q>0, else 5
    inputBinding:
      position: 103
      prefix: -r
  - id: matsym
    type:
      - 'null'
      - boolean
    doc: force symmetric substitution matrix
    inputBinding:
      position: 103
      prefix: --matsym
  - id: max_expected_alignments_per_square_giga
    type:
      - 'null'
      - float
    doc: maximum expected alignments per square giga
    inputBinding:
      position: 103
      prefix: -E
  - id: max_initial_matches_per_query_position
    type:
      - 'null'
      - int
    doc: maximum initial matches per query position
    default: 10
    inputBinding:
      position: 103
      prefix: -m
  - id: mismatch_cost
    type:
      - 'null'
      - float
    doc: mismatch cost
    default: 18 if Q>0, else 5
    inputBinding:
      position: 103
      prefix: -q
  - id: omit_gapless_alignments_count
    type:
      - 'null'
      - int
    doc: omit gapless alignments in COUNT others with > score-per-length
    inputBinding:
      position: 103
      prefix: -C
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: pid
    type:
      - 'null'
      - float
    doc: skip alignments with > PID% identity
    default: 100
    inputBinding:
      position: 103
      prefix: --pid
  - id: postmask
    type:
      - 'null'
      - float
    doc: skip mostly-lowercase alignments
    default: 1
    inputBinding:
      position: 103
      prefix: --postmask
  - id: query_letters_per_random_alignment
    type:
      - 'null'
      - int
    doc: query letters per random alignment
    default: '1e6'
    inputBinding:
      position: 103
      prefix: -D
  - id: revsym
    type:
      - 'null'
      - boolean
    doc: force reverse-complement symmetry
    inputBinding:
      position: 103
      prefix: --revsym
  - id: sample_length
    type:
      - 'null'
      - int
    doc: length of each sample
    default: 2000
    inputBinding:
      position: 103
      prefix: --sample-length
  - id: sample_number
    type:
      - 'null'
      - int
    doc: number of random sequence samples
    default: 500
    inputBinding:
      position: 103
      prefix: --sample-number
  - id: score_matrix_forward_strand_of
    type:
      - 'null'
      - int
    doc: 'score matrix applies to forward strand of: 0=reference, 1=query'
    default: 1
    inputBinding:
      position: 103
      prefix: -S
  - id: strand
    type:
      - 'null'
      - int
    doc: 0=reverse, 1=forward, 2=both
    default: 2 if DNA, else 1
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more details of intermediate steps
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
stdout: last-align_last-train.out
