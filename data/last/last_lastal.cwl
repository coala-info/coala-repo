cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastal
label: last_lastal
doc: Find and align similar sequences.
inputs:
  - id: lastdb_name
    type: string
    doc: Name of the lastdb index
    inputBinding:
      position: 1
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: Query fasta sequence file(s)
    inputBinding:
      position: 2
  - id: paired_query
    type:
      - 'null'
      - boolean
    doc: paired query sequences
    inputBinding:
      position: 103
      prefix: '-2'
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output format: TAB, MAF, BlastTab, BlastTab+'
    inputBinding:
      position: 103
      prefix: -f
  - id: query_letters_per_random_alignment
    type:
      - 'null'
      - float
    doc: query letters per random alignment
    inputBinding:
      position: 103
      prefix: -D
  - id: expected_random_alignments_total
    type:
      - 'null'
      - float
    doc: expected total number of random alignments for all the sequences
    inputBinding:
      position: 103
      prefix: -H
  - id: max_eg2
    type:
      - 'null'
      - float
    doc: 'max EG2: expected number of random alignments per square giga'
    inputBinding:
      position: 103
      prefix: -E
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score (2 if -M, else 1)
    inputBinding:
      position: 103
      prefix: -r
  - id: mismatch_cost
    type:
      - 'null'
      - int
    doc: mismatch cost (3 if -M, else 1)
    inputBinding:
      position: 103
      prefix: -q
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: 'match/mismatch score matrix (DNA-DNA: HUMSUM, protein-protein: BLOSUM62,
      DNA-protein: BLOSUM80)'
    inputBinding:
      position: 103
      prefix: -p
  - id: ambiguous_n_x
    type:
      - 'null'
      - int
    doc: 'N/X is ambiguous in: 0=neither sequence, 1=reference, 2=query, 3=both'
    inputBinding:
      position: 103
      prefix: -X
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
  - id: unaligned_residue_pair_cost
    type:
      - 'null'
      - int
    doc: unaligned residue pair cost
    inputBinding:
      position: 103
      prefix: -c
  - id: frameshift_cost
    type:
      - 'null'
      - string
    doc: frameshift cost(s)
    inputBinding:
      position: 103
      prefix: -F
  - id: max_score_drop_preliminary
    type:
      - 'null'
      - int
    doc: maximum score drop for preliminary gapped alignments
    inputBinding:
      position: 103
      prefix: -x
  - id: max_score_drop_gapless
    type:
      - 'null'
      - int
    doc: maximum score drop for gapless alignments
    inputBinding:
      position: 103
      prefix: -y
  - id: max_score_drop_final
    type:
      - 'null'
      - int
    doc: maximum score drop for final gapped alignments
    inputBinding:
      position: 103
      prefix: -z
  - id: min_score_gapless
    type:
      - 'null'
      - int
    doc: minimum score for gapless alignments
    inputBinding:
      position: 103
      prefix: -d
  - id: min_score_gapped
    type:
      - 'null'
      - int
    doc: minimum score for gapped alignments
    inputBinding:
      position: 103
      prefix: -e
  - id: max_initial_matches
    type:
      - 'null'
      - int
    doc: maximum initial matches per query position
    inputBinding:
      position: 103
      prefix: -m
  - id: min_length_initial_matches
    type:
      - 'null'
      - int
    doc: minimum length for initial matches
    inputBinding:
      position: 103
      prefix: -l
  - id: max_length_initial_matches
    type:
      - 'null'
      - string
    doc: maximum length for initial matches
    inputBinding:
      position: 103
      prefix: -L
  - id: initial_match_step
    type:
      - 'null'
      - int
    doc: use initial matches starting at every k-th position in each query
    inputBinding:
      position: 103
      prefix: -k
  - id: sliding_window_width
    type:
      - 'null'
      - int
    doc: use "minimum" positions in sliding windows of W consecutive positions
    inputBinding:
      position: 103
      prefix: -W
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: omit_alignments_k
    type:
      - 'null'
      - int
    doc: omit alignments whose query range lies in >= K others with > score
    inputBinding:
      position: 103
      prefix: -K
  - id: omit_gapless_alignments_c
    type:
      - 'null'
      - int
    doc: omit gapless alignments in >= C others with > score-per-length
    inputBinding:
      position: 103
      prefix: -C
  - id: strand
    type:
      - 'null'
      - int
    doc: 'strand: 0=reverse, 1=forward, 2=both'
    inputBinding:
      position: 103
      prefix: -s
  - id: reverse_query
    type:
      - 'null'
      - boolean
    doc: reverse the query sequences
    inputBinding:
      position: 103
      prefix: --reverse
  - id: use_score_matrix_mode
    type:
      - 'null'
      - int
    doc: 'use score matrix: 0=as-is, 1=on query forward strands'
    inputBinding:
      position: 103
      prefix: -S
  - id: query_batch_size
    type:
      - 'null'
      - string
    doc: query batch size
    inputBinding:
      position: 103
      prefix: -i
  - id: min_difference_alignments
    type:
      - 'null'
      - boolean
    doc: find minimum-difference alignments (faster but cruder)
    inputBinding:
      position: 103
      prefix: -M
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: 'type of alignment: 0=local, 1=overlap'
    inputBinding:
      position: 103
      prefix: -T
  - id: max_gapless_per_position
    type:
      - 'null'
      - string
    doc: maximum gapless alignments per query position
    inputBinding:
      position: 103
      prefix: -n
  - id: stop_after_n_alignments
    type:
      - 'null'
      - int
    doc: stop after the first N alignments per query strand
    inputBinding:
      position: 103
      prefix: -N
  - id: lastdb_options
    type:
      - 'null'
      - boolean
    doc: lowercase & simple-sequence options (the same as was used by lastdb)
    inputBinding:
      position: 103
      prefix: -R
  - id: max_tandem_repeat_length
    type:
      - 'null'
      - int
    doc: maximum tandem repeat unit length
    inputBinding:
      position: 103
      prefix: -U
  - id: mask_lowercase
    type:
      - 'null'
      - int
    doc: 'mask lowercase during extensions: 0=never, 1=gapless, 2=gapless+postmask,
      3=always'
    inputBinding:
      position: 103
      prefix: -u
  - id: suppress_repeats_distance
    type:
      - 'null'
      - int
    doc: suppress repeats inside exact matches, offset by <= this distance
    inputBinding:
      position: 103
      prefix: -w
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code
    inputBinding:
      position: 103
      prefix: -G
  - id: temperature
    type:
      - 'null'
      - float
    doc: "'temperature' for calculating probabilities (1/lambda)"
    inputBinding:
      position: 103
      prefix: -t
  - id: gamma
    type:
      - 'null'
      - float
    doc: "'gamma' parameter for gamma-centroid and LAMA"
    inputBinding:
      position: 103
      prefix: -g
  - id: output_type
    type:
      - 'null'
      - int
    doc: 'output type: 0=match counts, 1=gapless, 2=redundant gapped, 3=gapped, 4=column
      ambiguity estimates, 5=gamma-centroid, 6=LAMA, 7=expected counts'
    inputBinding:
      position: 103
      prefix: -j
  - id: score_type
    type:
      - 'null'
      - int
    doc: 'score type: 0=ordinary, 1=full'
    inputBinding:
      position: 103
      prefix: -J
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: fastx, keep, sanger, solexa, illumina, prb, pssm'
    inputBinding:
      position: 103
      prefix: -Q
  - id: split
    type:
      - 'null'
      - boolean
    doc: do split alignment
    inputBinding:
      position: 103
      prefix: --split
  - id: splice
    type:
      - 'null'
      - boolean
    doc: do spliced alignment
    inputBinding:
      position: 103
      prefix: --splice
  - id: split_format
    type:
      - 'null'
      - string
    doc: 'output format: MAF, MAF+'
    inputBinding:
      position: 103
      prefix: --split-f
  - id: split_direction
    type:
      - 'null'
      - int
    doc: 'RNA direction: 0=reverse, 1=forward, 2=mixed'
    inputBinding:
      position: 103
      prefix: --split-d
  - id: split_cis_prob
    type:
      - 'null'
      - float
    doc: cis-splice probability per base
    inputBinding:
      position: 103
      prefix: --split-c
  - id: split_trans_prob
    type:
      - 'null'
      - float
    doc: trans-splice probability per base
    inputBinding:
      position: 103
      prefix: --split-t
  - id: split_mean_intron
    type:
      - 'null'
      - float
    doc: mean of ln[intron length]
    inputBinding:
      position: 103
      prefix: --split-M
  - id: split_sdev_intron
    type:
      - 'null'
      - float
    doc: standard deviation of ln[intron length]
    inputBinding:
      position: 103
      prefix: --split-S
  - id: split_max_mismap
    type:
      - 'null'
      - float
    doc: maximum mismap probability
    inputBinding:
      position: 103
      prefix: --split-m
  - id: split_min_score
    type:
      - 'null'
      - string
    doc: minimum alignment score
    inputBinding:
      position: 103
      prefix: --split-s
  - id: split_write_original
    type:
      - 'null'
      - boolean
    doc: write original, not split, alignments
    inputBinding:
      position: 103
      prefix: --split-n
  - id: split_max_memory
    type:
      - 'null'
      - string
    doc: 'maximum memory (default: 8T for split, 8G for spliced)'
    inputBinding:
      position: 103
      prefix: --split-b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last_lastal.out
s:url: https://gitlab.com/mcfrith/last
$namespaces:
  s: https://schema.org/
