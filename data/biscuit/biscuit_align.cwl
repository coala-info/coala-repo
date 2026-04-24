cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - align
label: biscuit_align
doc: "Align bisulfite-treated sequencing reads to a reference genome\n\nTool homepage:
  https://github.com/huishenlab/biscuit"
inputs:
  - id: fai_index_base
    type: File
    doc: fai-index base
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
    doc: Input FASTQ file 2 (for paired-end reads)
    inputBinding:
      position: 3
  - id: adaptor_read1
    type:
      - 'null'
      - string
    doc: Adaptor of read 1 (fastq direction)
    inputBinding:
      position: 104
      prefix: -J
  - id: adaptor_read2
    type:
      - 'null'
      - string
    doc: Adaptor of read 2 (fastq direction)
    inputBinding:
      position: 104
      prefix: -K
  - id: align_read_1
    type:
      - 'null'
      - string
    doc: Align a single read STR
    inputBinding:
      position: 104
      prefix: '-1'
  - id: align_read_2
    type:
      - 'null'
      - string
    doc: Align a read STR paired with -1 read
    inputBinding:
      position: 104
      prefix: '-2'
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
    inputBinding:
      position: 104
      prefix: -w
  - id: clip_3p
    type:
      - 'null'
      - int
    doc: Number of extra bases to clip from 3'-end
    inputBinding:
      position: 104
      prefix: '-3'
  - id: clip_5p
    type:
      - 'null'
      - int
    doc: Number of extra bases to clip from 5'-end
    inputBinding:
      position: 104
      prefix: '-5'
  - id: clipping_penalty
    type:
      - 'null'
      - string
    doc: Penalty for 5'- and 3'-end clipping
    inputBinding:
      position: 104
      prefix: -L
  - id: discard_exact_matches
    type:
      - 'null'
      - boolean
    doc: Discard full-length exact matches
    inputBinding:
      position: 104
      prefix: -e
  - id: drop_chain_fraction
    type:
      - 'null'
      - float
    doc: Drop chains shorter than FLOAT fraction of the longest overlapping chain
    inputBinding:
      position: 104
      prefix: -D
  - id: extract_barcode_umi
    type:
      - 'null'
      - boolean
    doc: Extract barcode and UMI from read name
    inputBinding:
      position: 104
      prefix: '-9'
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: Gap extension penalty
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
  - id: header_insert
    type:
      - 'null'
      - string
    doc: Insert STR to header if it starts with @ or insert lines in FILE
    inputBinding:
      position: 104
      prefix: -H
  - id: ignore_alt_file
    type:
      - 'null'
      - boolean
    doc: Treat ALT contigs as part of the primary assembly
    inputBinding:
      position: 104
      prefix: -j
  - id: insert_size_dist
    type:
      - 'null'
      - string
    doc: Specify the mean, standard deviation, maximum and minimum of insert size
      distribution.
    inputBinding:
      position: 104
      prefix: -I
  - id: internal_seed_ratio
    type:
      - 'null'
      - float
    doc: Look for internal seeds inside a seed longer than {-k}*FLOAT
    inputBinding:
      position: 104
      prefix: -r
  - id: library_type
    type:
      - 'null'
      - int
    doc: 'For PE, map read 1 to parent, read 2 to daughter (1: directional library)
      or read1 and read 2 to both (0: non-directional library [default]). For SE,
      parent (1), daughter (3), or both (0 [default]).'
    inputBinding:
      position: 104
      prefix: -b
  - id: mark_short_split_secondary
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
    doc: Score for a sequence match, scales options -TdBOELU unless overridden
    inputBinding:
      position: 104
      prefix: -A
  - id: mate_rescues
    type:
      - 'null'
      - int
    doc: Perform at most INT rounds of mate rescues for a read
    inputBinding:
      position: 104
      prefix: -m
  - id: max_seed_occurrences
    type:
      - 'null'
      - int
    doc: Skip seeds with more than INT occurrences
    inputBinding:
      position: 104
      prefix: -c
  - id: max_xa_hits
    type:
      - 'null'
      - string
    doc: Maximum number of hits output in XA
    inputBinding:
      position: 104
      prefix: -g
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to keep from both ends of reads
    inputBinding:
      position: 104
      prefix: -z
  - id: min_output_score
    type:
      - 'null'
      - int
    doc: Minimum score to output
    inputBinding:
      position: 104
      prefix: -T
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: Minimum seed length
    inputBinding:
      position: 104
      prefix: -k
  - id: min_seeded_bases
    type:
      - 'null'
      - int
    doc: Discard a chain if seeded bases shorter than INT
    inputBinding:
      position: 104
      prefix: -W
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a mismatch
    inputBinding:
      position: 104
      prefix: -B
  - id: no_autoinference_alt
    type:
      - 'null'
      - boolean
    doc: Turn off autoinference of ALT chromosomes
    inputBinding:
      position: 104
      prefix: -i
  - id: no_modify_mapq
    type:
      - 'null'
      - boolean
    doc: Do not modify mapQ of supplementary alignments
    inputBinding:
      position: 104
      prefix: -q
  - id: off_diagonal_dropoff
    type:
      - 'null'
      - int
    doc: Off-diagonal X-dropoff
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
  - id: output_ref_header_xr
    type:
      - 'null'
      - boolean
    doc: Output the reference FASTA header in the XR tag
    inputBinding:
      position: 104
      prefix: -V
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: Read group header line (such as '@RG\tID:foo\tSM:bar')
    inputBinding:
      position: 104
      prefix: -R
  - id: seed_occurrence_round3
    type:
      - 'null'
      - int
    doc: Seed occurrence for the 3rd round of seeding
    inputBinding:
      position: 104
      prefix: -y
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
    doc: Skip pairing - mate rescue performed unless -S also given
    inputBinding:
      position: 104
      prefix: -P
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: Smart pairing (ignores in2.fq)
    inputBinding:
      position: 104
      prefix: -p
  - id: soft_clipping_supp
    type:
      - 'null'
      - boolean
    doc: Use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: strand_target
    type:
      - 'null'
      - int
    doc: '1: BSW strand; 3: BSC strand; 0: both.'
    inputBinding:
      position: 104
      prefix: -f
  - id: suppress_sam_header
    type:
      - 'null'
      - boolean
    doc: Suppress SAM header output
    inputBinding:
      position: 104
      prefix: -F
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: -@
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: Penalty for an unpaired read pair
    inputBinding:
      position: 104
      prefix: -U
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 1: error, 2: warning, 3: message, 4+: debugging'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_align.out
