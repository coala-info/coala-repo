cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastal
label: last-align_lastal
doc: "Find and align similar sequences.\n\nTool homepage: https://gitlab.com/mcfrith/last"
inputs:
  - id: lastdb_name
    type: string
    doc: lastdb-name
    inputBinding:
      position: 1
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: fasta-sequence-file(s)
    inputBinding:
      position: 2
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: 'type of alignment: 0=local, 1=overlap'
    inputBinding:
      position: 103
      prefix: -T
  - id: find_minimum_difference_alignments
    type:
      - 'null'
      - boolean
    doc: find minimum-difference alignments (faster but cruder)
    inputBinding:
      position: 103
      prefix: -M
  - id: frameshift_cost
    type:
      - 'null'
      - string
    doc: frameshift cost (off)
    inputBinding:
      position: 103
      prefix: -F
  - id: gamma_parameter
    type:
      - 'null'
      - int
    doc: "'gamma' parameter for gamma-centroid and LAMA"
    inputBinding:
      position: 103
      prefix: -g
  - id: gap_existence_cost
    type:
      - 'null'
      - string
    doc: 'gap existence cost (DNA: 7, protein: 11, 0<Q<5: 21)'
    inputBinding:
      position: 103
      prefix: -a
  - id: gap_extension_cost
    type:
      - 'null'
      - string
    doc: 'gap extension cost (DNA: 1, protein:  2, 0<Q<5:  9)'
    inputBinding:
      position: 103
      prefix: -b
  - id: genetic_code_file
    type:
      - 'null'
      - File
    doc: genetic code file
    inputBinding:
      position: 103
      prefix: -G
  - id: initial_matches_every_k_positions
    type:
      - 'null'
      - int
    doc: use initial matches starting at every k-th position in each query
    inputBinding:
      position: 103
      prefix: -k
  - id: input_format
    type:
      - 'null'
      - int
    doc: "input format: 0=fasta or fastq-ignore, 1=fastq-sanger, 2=fastq-solexa,\n\
      \                  3=fastq-illumina, 4=prb, 5=PSSM (fasta)"
    inputBinding:
      position: 103
      prefix: -Q
  - id: insertion_existence_cost
    type:
      - 'null'
      - string
    doc: insertion existence cost (a)
    inputBinding:
      position: 103
      prefix: -A
  - id: insertion_extension_cost
    type:
      - 'null'
      - string
    doc: insertion extension cost (b)
    inputBinding:
      position: 103
      prefix: -B
  - id: mask_lowercase_during_extensions
    type:
      - 'null'
      - string
    doc: "mask lowercase during extensions: 0=never, 1=gapless,\n    2=gapless+postmask,
      3=always (2 if lastdb -c and Q<5, else 0)"
    inputBinding:
      position: 103
      prefix: -u
  - id: match_score
    type:
      - 'null'
      - string
    doc: match score   (2 if -M, else  6 if 0<Q<5, else 1 if DNA)
    inputBinding:
      position: 103
      prefix: -r
  - id: max_expected_alignments_per_square_giga
    type:
      - 'null'
      - string
    doc: maximum expected alignments per square giga 
      (1e+18/D/refSize/numOfStrands)
    inputBinding:
      position: 103
      prefix: -E
  - id: max_gapless_alignments_per_query_position
    type:
      - 'null'
      - string
    doc: maximum gapless alignments per query position (infinity if m=0, else m)
    inputBinding:
      position: 103
      prefix: -n
  - id: max_initial_matches
    type:
      - 'null'
      - int
    doc: maximum initial matches per query position
    inputBinding:
      position: 103
      prefix: -m
  - id: max_length_initial_matches
    type:
      - 'null'
      - string
    doc: maximum length for initial matches (infinity)
    inputBinding:
      position: 103
      prefix: -L
  - id: max_score_drop_final_gapped
    type:
      - 'null'
      - string
    doc: maximum score drop for final gapped alignments (e-1)
    inputBinding:
      position: 103
      prefix: -z
  - id: max_score_drop_gapless
    type:
      - 'null'
      - string
    doc: maximum score drop for gapless alignments (min[t*10, x])
    inputBinding:
      position: 103
      prefix: -y
  - id: max_score_drop_preliminary_gapped
    type:
      - 'null'
      - string
    doc: maximum score drop for preliminary gapped alignments (z)
    inputBinding:
      position: 103
      prefix: -x
  - id: min_length_initial_matches
    type:
      - 'null'
      - int
    doc: minimum length for initial matches
    inputBinding:
      position: 103
      prefix: -l
  - id: min_positions_sliding_windows
    type:
      - 'null'
      - string
    doc: use "minimum" positions in sliding windows of W consecutive positions
    inputBinding:
      position: 103
      prefix: -W
  - id: min_score_gapless
    type:
      - 'null'
      - string
    doc: minimum score for gapless alignments (min[e, t*ln(1000*refSize/n)])
    inputBinding:
      position: 103
      prefix: -d
  - id: min_score_gapped
    type:
      - 'null'
      - string
    doc: minimum score for gapped alignments
    inputBinding:
      position: 103
      prefix: -e
  - id: mismatch_cost
    type:
      - 'null'
      - string
    doc: mismatch cost (3 if -M, else 18 if 0<Q<5, else 1 if DNA)
    inputBinding:
      position: 103
      prefix: -q
  - id: omit_alignments_in_others
    type:
      - 'null'
      - string
    doc: omit alignments whose query range lies in >= K others with > score 
      (off)
    inputBinding:
      position: 103
      prefix: -K
  - id: omit_gapless_alignments_in_others
    type:
      - 'null'
      - string
    doc: omit gapless alignments in >= C others with > score-per-length (off)
    inputBinding:
      position: 103
      prefix: -C
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output format: TAB, MAF, BlastTab, BlastTab+ (default=MAF)'
    inputBinding:
      position: 103
      prefix: -f
  - id: output_type
    type:
      - 'null'
      - int
    doc: "output type: 0=match counts, 1=gapless, 2=redundant gapped, 3=gapped,\n\
      \                 4=column ambiguity estimates, 5=gamma-centroid, 6=LAMA, 7=expected
      counts"
    inputBinding:
      position: 103
      prefix: -j
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 103
      prefix: -P
  - id: query_batch_size
    type:
      - 'null'
      - string
    doc: query batch size (8 KiB, unless there is > 1 thread or lastdb volume)
    inputBinding:
      position: 103
      prefix: -i
  - id: query_letters_per_random_alignment
    type:
      - 'null'
      - float
    doc: query letters per random alignment
    inputBinding:
      position: 103
      prefix: -D
  - id: repeat_marking_options
    type:
      - 'null'
      - string
    doc: repeat-marking options (the same as was used for lastdb)
    inputBinding:
      position: 103
      prefix: -R
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: 'match/mismatch score matrix (protein-protein: BL62, DNA-protein: BL80)'
    inputBinding:
      position: 103
      prefix: -p
  - id: score_matrix_forward_strand_of
    type:
      - 'null'
      - int
    doc: 'score matrix applies to forward strand of: 0=reference, 1=query'
    inputBinding:
      position: 103
      prefix: -S
  - id: stop_after_first_n_alignments
    type:
      - 'null'
      - string
    doc: stop after the first N alignments per query strand
    inputBinding:
      position: 103
      prefix: -N
  - id: strand
    type:
      - 'null'
      - string
    doc: 'strand: 0=reverse, 1=forward, 2=both (2 for DNA, 1 for protein)'
    inputBinding:
      position: 103
      prefix: -s
  - id: suppress_repeats_inside_exact_matches
    type:
      - 'null'
      - int
    doc: suppress repeats inside exact matches, offset by <= this distance
    inputBinding:
      position: 103
      prefix: -w
  - id: temperature
    type:
      - 'null'
      - string
    doc: "'temperature' for calculating probabilities (1/lambda)"
    inputBinding:
      position: 103
      prefix: -t
  - id: unaligned_residue_pair_cost
    type:
      - 'null'
      - string
    doc: unaligned residue pair cost (off)
    inputBinding:
      position: 103
      prefix: -c
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'be verbose: write messages about what lastal is doing'
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
stdout: last-align_lastal.out
