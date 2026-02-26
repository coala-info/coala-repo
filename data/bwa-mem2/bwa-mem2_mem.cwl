cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-mem2
  - mem
label: bwa-mem2_mem
doc: "Align sequences to the reference genome.\n\nTool homepage: https://github.com/bwa-mem2/bwa-mem2"
inputs:
  - id: idxbase
    type: string
    doc: The prefix of the BWA index
    inputBinding:
      position: 1
  - id: in1_fq
    type: File
    doc: The first FASTQ file
    inputBinding:
      position: 2
  - id: in2_fq
    type:
      - 'null'
      - File
    doc: The second FASTQ file (for paired-end reads)
    inputBinding:
      position: 3
  - id: append_comment
    type:
      - 'null'
      - boolean
    doc: Append FASTA/FASTQ comment to SAM output
    inputBinding:
      position: 104
      prefix: -C
  - id: band_width
    type:
      - 'null'
      - int
    doc: Band width for banded alignment
    default: 100
    inputBinding:
      position: 104
      prefix: -w
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Process INT input bases in each batch regardless of nThreads (for 
      reproducibility)
    inputBinding:
      position: 104
      prefix: -K
  - id: end_clip_penalty
    type:
      - 'null'
      - string
    doc: Penalty for 5'- and 3'-end clipping
    inputBinding:
      position: 104
      prefix: -L
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: Gap extension penalty; a gap of size k cost '{-O} + {-E}*k'
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: Gap open penalties for deletions and insertions
    inputBinding:
      position: 104
      prefix: -O
  - id: header_line
    type:
      - 'null'
      - string
    doc: Insert STR to header if it starts with @; or insert lines in FILE
    inputBinding:
      position: 104
      prefix: -H
  - id: ignore_alt_contigs
    type:
      - 'null'
      - boolean
    doc: Treat ALT contigs as part of the primary assembly (i.e. ignore 
      <idxbase>.alt file)
    inputBinding:
      position: 104
      prefix: -j
  - id: insert_size_distribution
    type:
      - 'null'
      - string
    doc: Specify the mean, standard deviation (10% of the mean if absent), max 
      (4 sigma from the mean if absent) and min of the insert size distribution.
      FR orientation only.
    inputBinding:
      position: 104
      prefix: -I
  - id: mark_shorter_split_secondary
    type:
      - 'null'
      - boolean
    doc: Mark shorter split hits as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: match_score
    type:
      - 'null'
      - int
    doc: Score for a sequence match, which scales options -TdBOELU unless 
      overridden
    default: 1
    inputBinding:
      position: 104
      prefix: -A
  - id: max_mate_rescues
    type:
      - 'null'
      - int
    doc: Perform at most INT rounds of mate rescues for each read
    default: 50
    inputBinding:
      position: 104
      prefix: -m
  - id: max_score_hits
    type:
      - 'null'
      - string
    doc: If there are <INT hits with score >80% of the max score, output all in 
      XA
    inputBinding:
      position: 104
      prefix: -h
  - id: max_seed_occurrences
    type:
      - 'null'
      - int
    doc: Skip seeds with more than INT occurrences
    default: 500
    inputBinding:
      position: 104
      prefix: -c
  - id: min_chain_fraction
    type:
      - 'null'
      - float
    doc: Drop chains shorter than FLOAT fraction of the longest overlapping 
      chain
    default: 0.5
    inputBinding:
      position: 104
      prefix: -D
  - id: min_score_output
    type:
      - 'null'
      - int
    doc: Minimum score to output
    default: 30
    inputBinding:
      position: 104
      prefix: -T
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: Minimum seed length
    default: 19
    inputBinding:
      position: 104
      prefix: -k
  - id: min_seeded_bases_for_chain
    type:
      - 'null'
      - int
    doc: Discard a chain if seeded bases shorter than INT
    default: 0
    inputBinding:
      position: 104
      prefix: -W
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a mismatch
    default: 4
    inputBinding:
      position: 104
      prefix: -B
  - id: no_mapq_modify_supplementary
    type:
      - 'null'
      - boolean
    doc: Don't modify mapQ of supplementary alignments
    inputBinding:
      position: 104
      prefix: -q
  - id: off_diagonal_dropoff
    type:
      - 'null'
      - int
    doc: Off-diagonal X-dropoff
    default: 100
    inputBinding:
      position: 104
      prefix: -d
  - id: output_all_alignments
    type:
      - 'null'
      - boolean
    doc: Output all alignments for SE or unpaired PE
    inputBinding:
      position: 104
      prefix: -a
  - id: output_reference_header
    type:
      - 'null'
      - boolean
    doc: Output the reference FASTA header in the XR tag
    inputBinding:
      position: 104
      prefix: -V
  - id: primary_alignment_min_coord
    type:
      - 'null'
      - boolean
    doc: For split alignment, take the alignment with the smallest coordinate as
      primary
    inputBinding:
      position: 104
      prefix: '-5'
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: Read group header line such as '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 104
      prefix: -R
  - id: seed_extension_factor
    type:
      - 'null'
      - float
    doc: Look for internal seeds inside a seed longer than {-k} * FLOAT
    inputBinding:
      position: 104
      prefix: -r
  - id: skip_mate_rescue
    type:
      - 'null'
      - boolean
    doc: Skip mate rescue
    inputBinding:
      position: 104
      prefix: -S
  - id: skip_pairing
    type:
      - 'null'
      - boolean
    doc: Skip pairing; mate rescue performed unless -S also in use
    inputBinding:
      position: 104
      prefix: -P
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: Smart pairing (ignoring in2.fq)
    inputBinding:
      position: 104
      prefix: -p
  - id: third_round_seed_occurrence
    type:
      - 'null'
      - int
    doc: Seed occurrence for the 3rd round seeding
    default: 20
    inputBinding:
      position: 104
      prefix: -y
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 104
      prefix: -t
  - id: unpaired_read_penalty
    type:
      - 'null'
      - int
    doc: Penalty for an unpaired read pair
    default: 17
    inputBinding:
      position: 104
      prefix: -U
  - id: use_soft_clipping
    type:
      - 'null'
      - boolean
    doc: Use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level: 1=error, 2=warning, 3=message, 4+=debugging'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
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
    dockerPull: quay.io/biocontainers/bwa-mem2:2.3--he70b90d_0
