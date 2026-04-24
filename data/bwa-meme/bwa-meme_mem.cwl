cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-meme
  - mem
label: bwa-meme_mem
doc: "BWA-MEME (bwa-mem2) alignment tool using learned or ERT indexes for seeding.\n
  \nTool homepage: https://github.com/kaist-ina/BWA-MEME"
inputs:
  - id: idxbase
    type: File
    doc: Index basename
    inputBinding:
      position: 1
  - id: in1_fq
    type: File
    doc: Input FASTQ file 1
    inputBinding:
      position: 2
  - id: in2_fq
    type:
      - 'null'
      - File
    doc: Input FASTQ file 2 (optional)
    inputBinding:
      position: 3
  - id: append_comment
    type:
      - 'null'
      - boolean
    doc: append FASTA/FASTQ comment to SAM output
    inputBinding:
      position: 104
      prefix: -C
  - id: band_width
    type:
      - 'null'
      - int
    doc: band width for banded alignment
    inputBinding:
      position: 104
      prefix: -w
  - id: batch_size_bases
    type:
      - 'null'
      - int
    doc: process INT input bases in each batch regardless of nThreads
    inputBinding:
      position: 104
      prefix: -K
  - id: chain_drop_fraction
    type:
      - 'null'
      - float
    doc: drop chains shorter than FLOAT fraction of the longest overlapping chain
    inputBinding:
      position: 104
      prefix: -D
  - id: clipping_penalty
    type:
      - 'null'
      - string
    doc: penalty for 5'- and 3'-end clipping
    inputBinding:
      position: 104
      prefix: -L
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalties for deletions and insertions
    inputBinding:
      position: 104
      prefix: -O
  - id: header_insert
    type:
      - 'null'
      - string
    doc: insert STR to header if it starts with @; or insert lines in FILE
    inputBinding:
      position: 104
      prefix: -H
  - id: insert_size_distribution
    type:
      - 'null'
      - string
    doc: specify the mean, standard deviation, max and min of the insert size distribution
    inputBinding:
      position: 104
      prefix: -I
  - id: internal_seed_threshold
    type:
      - 'null'
      - float
    doc: look for internal seeds inside a seed longer than {-k} * FLOAT
    inputBinding:
      position: 104
      prefix: -r
  - id: keep_supp_mapq
    type:
      - 'null'
      - boolean
    doc: don't modify mapQ of supplementary alignments
    inputBinding:
      position: 104
      prefix: -q
  - id: mark_short_split_secondary
    type:
      - 'null'
      - boolean
    doc: mark shorter split hits as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: mate_rescues
    type:
      - 'null'
      - int
    doc: perform at most INT rounds of mate rescues for each read
    inputBinding:
      position: 104
      prefix: -m
  - id: min_score_output
    type:
      - 'null'
      - int
    doc: minimum score to output
    inputBinding:
      position: 104
      prefix: -T
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: minimum seed length
    inputBinding:
      position: 104
      prefix: -k
  - id: min_seeded_bases
    type:
      - 'null'
      - int
    doc: discard a chain if seeded bases shorter than INT
    inputBinding:
      position: 104
      prefix: -W
  - id: off_diagonal_dropoff
    type:
      - 'null'
      - int
    doc: off-diagonal X-dropoff
    inputBinding:
      position: 104
      prefix: -d
  - id: output_all_alignments
    type:
      - 'null'
      - boolean
    doc: output all alignments for SE or unpaired PE
    inputBinding:
      position: 104
      prefix: -a
  - id: output_ref_header_xr
    type:
      - 'null'
      - boolean
    doc: output the reference FASTA header in the XR tag
    inputBinding:
      position: 104
      prefix: -V
  - id: penalty_mismatch
    type:
      - 'null'
      - int
    doc: penalty for a mismatch
    inputBinding:
      position: 104
      prefix: -B
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: read group header line such as '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 104
      prefix: -R
  - id: score_match
    type:
      - 'null'
      - int
    doc: score for a sequence match
    inputBinding:
      position: 104
      prefix: -A
  - id: seed_occurrence_3rd_round
    type:
      - 'null'
      - int
    doc: seed occurrence for the 3rd round seeding
    inputBinding:
      position: 104
      prefix: -y
  - id: skip_mate_rescue
    type:
      - 'null'
      - boolean
    doc: skip mate rescue
    inputBinding:
      position: 104
      prefix: -S
  - id: skip_pairing
    type:
      - 'null'
      - boolean
    doc: skip pairing; mate rescue performed unless -S also in use
    inputBinding:
      position: 104
      prefix: -P
  - id: skip_seeds_occurrence
    type:
      - 'null'
      - int
    doc: skip seeds with more than INT occurrences
    inputBinding:
      position: 104
      prefix: -c
  - id: smallest_coord_primary
    type:
      - 'null'
      - boolean
    doc: for split alignment, take the alignment with the smallest coordinate as primary
    inputBinding:
      position: 104
      prefix: '-5'
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: smart pairing (ignoring in2.fq)
    inputBinding:
      position: 104
      prefix: -p
  - id: soft_clipping_supp
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: treat_alt_as_primary
    type:
      - 'null'
      - boolean
    doc: treat ALT contigs as part of the primary assembly
    inputBinding:
      position: 104
      prefix: -j
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: penalty for an unpaired read pair
    inputBinding:
      position: 104
      prefix: -U
  - id: use_ert_index
    type:
      - 'null'
      - boolean
    doc: Use ERT index for seeding
    inputBinding:
      position: 104
      prefix: -Z
  - id: use_learned_index
    type:
      - 'null'
      - boolean
    doc: Use Learned index for seeding (use BWA-MEME)
    inputBinding:
      position: 104
      prefix: '-7'
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging'
    inputBinding:
      position: 104
      prefix: -v
  - id: xa_output_hits
    type:
      - 'null'
      - string
    doc: if there are <INT hits with score >80% of the max score, output all in XA
    inputBinding:
      position: 104
      prefix: -h
outputs:
  - id: output_sam
    type:
      - 'null'
      - File
    doc: Output SAM file name
    outputBinding:
      glob: $(inputs.output_sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
