cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-train
label: last_last-train
doc: Try to find suitable score parameters for aligning the given sequences.
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
  - id: revsym
    type:
      - 'null'
      - boolean
    doc: force reverse-complement symmetry
    inputBinding:
      position: 103
      prefix: --revsym
  - id: matsym
    type:
      - 'null'
      - boolean
    doc: force symmetric substitution matrix
    inputBinding:
      position: 103
      prefix: --matsym
  - id: gapsym
    type:
      - 'null'
      - boolean
    doc: force insertion/deletion symmetry
    inputBinding:
      position: 103
      prefix: --gapsym
  - id: fixmat
    type:
      - 'null'
      - string
    doc: fix the substitution probabilities to e.g. BLOSUM62
    inputBinding:
      position: 103
      prefix: --fixmat
  - id: pid
    type:
      - 'null'
      - int
    doc: skip alignments with > PID% identity
    inputBinding:
      position: 103
      prefix: --pid
  - id: postmask
    type:
      - 'null'
      - int
    doc: skip mostly-lowercase alignments
    inputBinding:
      position: 103
      prefix: --postmask
  - id: sample_number
    type:
      - 'null'
      - int
    doc: 'number of random sequence samples (default: 20000 if --codon else 500)'
    inputBinding:
      position: 103
      prefix: --sample-number
  - id: sample_length
    type:
      - 'null'
      - int
    doc: length of each sample
    inputBinding:
      position: 103
      prefix: --sample-length
  - id: scale
    type:
      - 'null'
      - float
    doc: output scores in units of 1/S bits
    inputBinding:
      position: 103
      prefix: --scale
  - id: codon
    type:
      - 'null'
      - boolean
    doc: DNA queries & protein reference, with frameshifts
    inputBinding:
      position: 103
      prefix: --codon
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score
    inputBinding:
      position: 103
      prefix: -r
  - id: mismatch_cost
    type:
      - 'null'
      - int
    doc: mismatch cost
    inputBinding:
      position: 103
      prefix: -q
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: match/mismatch score matrix
    inputBinding:
      position: 103
      prefix: -p
  - id: gap_existence_cost
    type:
      - 'null'
      - int
    doc: gap existence cost
    inputBinding:
      position: 103
      prefix: -a
  - id: gap_extension_cost
    type:
      - 'null'
      - int
    doc: gap extension cost
    inputBinding:
      position: 103
      prefix: -b
  - id: insertion_existence_cost
    type:
      - 'null'
      - int
    doc: insertion existence cost
    inputBinding:
      position: 103
      prefix: -A
  - id: insertion_extension_cost
    type:
      - 'null'
      - int
    doc: insertion extension cost
    inputBinding:
      position: 103
      prefix: -B
  - id: frameshift_probabilities
    type:
      - 'null'
      - string
    doc: 'frameshift probabilities: del-1,del-2,ins+1,ins+2'
    inputBinding:
      position: 103
      prefix: -F
  - id: query_letters_per_alignment
    type:
      - 'null'
      - int
    doc: 'query letters per random alignment (default: total sample length)'
    inputBinding:
      position: 103
      prefix: -D
  - id: max_expected_alignments
    type:
      - 'null'
      - float
    doc: maximum expected alignments per square giga
    inputBinding:
      position: 103
      prefix: -E
  - id: strand
    type:
      - 'null'
      - int
    doc: 0=reverse, 1=forward, 2=both
    inputBinding:
      position: 103
      prefix: -s
  - id: use_score_matrix
    type:
      - 'null'
      - int
    doc: 'use score matrix: 0=as-is, 1=on query forward strands'
    inputBinding:
      position: 103
      prefix: -S
  - id: omit_gapless_alignments
    type:
      - 'null'
      - int
    doc: omit gapless alignments in COUNT others with > score-per-length
    inputBinding:
      position: 103
      prefix: -C
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: 'type of alignment: 0=local, 1=overlap'
    inputBinding:
      position: 103
      prefix: -T
  - id: lowercase_options
    type:
      - 'null'
      - string
    doc: lowercase & simple-sequence options
    inputBinding:
      position: 103
      prefix: -R
  - id: max_initial_matches
    type:
      - 'null'
      - int
    doc: maximum initial matches per query position
    inputBinding:
      position: 103
      prefix: -m
  - id: step_size
    type:
      - 'null'
      - int
    doc: use initial matches starting at every STEP-th position in each query
    inputBinding:
      position: 103
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: ambiguous_n
    type:
      - 'null'
      - int
    doc: 'N/X is ambiguous in: 0=neither sequence, 1=reference, 2=query, 3=both'
    inputBinding:
      position: 103
      prefix: -X
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: fastx, sanger'
    inputBinding:
      position: 103
      prefix: -Q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_last-train.out
s:url: https://gitlab.com/mcfrith/last
$namespaces:
  s: https://schema.org/
