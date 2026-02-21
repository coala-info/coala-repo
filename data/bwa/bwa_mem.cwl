cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - mem
label: bwa_mem
doc: "Burrows-Wheeler Alignment Tool, MEM algorithm for aligning low-divergence sequences
  against a large reference genome\n\nTool homepage: https://github.com/lh3/bwa"
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
    doc: Input FASTQ file 2
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
    default: 100
    inputBinding:
      position: 104
      prefix: -w
  - id: batch_size
    type:
      - 'null'
      - int
    doc: process INT input bases in each batch regardless of nThreads (for 
      reproducibility)
    inputBinding:
      position: 104
      prefix: -K
  - id: chain_drop_fraction
    type:
      - 'null'
      - float
    doc: drop chains shorter than FLOAT fraction of the longest overlapping 
      chain
    default: 0.5
    inputBinding:
      position: 104
      prefix: -D
  - id: clipping_penalty
    type:
      - 'null'
      - string
    doc: penalty for 5'- and 3'-end clipping
    default: 5,5
    inputBinding:
      position: 104
      prefix: -L
  - id: dont_modify_mapq
    type:
      - 'null'
      - boolean
    doc: don't modify mapQ of supplementary alignments
    inputBinding:
      position: 104
      prefix: -q
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a gap of size k cost '{-O} + {-E}*k'
    default: 1,1
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalties for deletions and insertions
    default: 6,6
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
  - id: ignore_alt_contigs
    type:
      - 'null'
      - boolean
    doc: treat ALT contigs as part of the primary assembly (i.e. ignore 
      <idxbase>.alt file)
    inputBinding:
      position: 104
      prefix: -j
  - id: insert_size_distribution
    type:
      - 'null'
      - string
    doc: specify the mean, standard deviation, max and min of the insert size 
      distribution
    inputBinding:
      position: 104
      prefix: -I
  - id: internal_seed_ratio
    type:
      - 'null'
      - float
    doc: look for internal seeds inside a seed longer than {-k} * FLOAT
    default: 1.5
    inputBinding:
      position: 104
      prefix: -r
  - id: mark_short_splits_secondary
    type:
      - 'null'
      - boolean
    doc: mark shorter split hits as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: match_score
    type:
      - 'null'
      - int
    doc: score for a sequence match, which scales options -TdBOELU unless 
      overridden
    default: 1
    inputBinding:
      position: 104
      prefix: -A
  - id: mate_rescue_rounds
    type:
      - 'null'
      - int
    doc: perform at most INT rounds of mate rescues for each read
    default: 50
    inputBinding:
      position: 104
      prefix: -m
  - id: max_score_fraction
    type:
      - 'null'
      - float
    doc: The fraction of the max score to use with -h
    default: 0.8
    inputBinding:
      position: 104
      prefix: -z
  - id: min_chain_seeded_bases
    type:
      - 'null'
      - int
    doc: discard a chain if seeded bases shorter than INT
    default: 0
    inputBinding:
      position: 104
      prefix: -W
  - id: min_score_output
    type:
      - 'null'
      - int
    doc: minimum score to output
    default: 30
    inputBinding:
      position: 104
      prefix: -T
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: minimum seed length
    default: 19
    inputBinding:
      position: 104
      prefix: -k
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: penalty for a mismatch
    default: 4
    inputBinding:
      position: 104
      prefix: -B
  - id: off_diagonal_dropoff
    type:
      - 'null'
      - int
    doc: off-diagonal X-dropoff
    default: 100
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
  - id: output_ref_header
    type:
      - 'null'
      - boolean
    doc: output the reference FASTA header in the XR tag
    inputBinding:
      position: 104
      prefix: -V
  - id: output_xb
    type:
      - 'null'
      - boolean
    doc: output XB instead of XA; XB is XA with the alignment score and mapping 
      quality added
    inputBinding:
      position: 104
      prefix: -u
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: read group header line such as '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 104
      prefix: -R
  - id: read_type
    type:
      - 'null'
      - string
    doc: read type (pacbio, ont2d, or intractg). Setting -x changes multiple 
      parameters unless overridden
    inputBinding:
      position: 104
      prefix: -x
  - id: seed_occurrence_3rd_round
    type:
      - 'null'
      - int
    doc: seed occurrence for the 3rd round seeding
    default: 20
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
  - id: skip_seeds_threshold
    type:
      - 'null'
      - int
    doc: skip seeds with more than INT occurrences
    default: 500
    inputBinding:
      position: 104
      prefix: -c
  - id: smallest_query_primary
    type:
      - 'null'
      - boolean
    doc: for split alignment, take the alignment with the smallest query (not 
      genomic) coordinate as primary
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
  - id: soft_clipping_supplementary
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
    default: 1
    inputBinding:
      position: 104
      prefix: -t
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: penalty for an unpaired read pair
    default: 17
    inputBinding:
      position: 104
      prefix: -U
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level: 1=error, 2=warning, 3=message, 4+=debugging'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
  - id: xa_output_threshold
    type:
      - 'null'
      - string
    doc: if there are <INT hits with score >80.00% of the max score, output all 
      in XA
    default: 5,200
    inputBinding:
      position: 104
      prefix: -h
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: sam file to output results to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
