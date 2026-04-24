cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr_fq2vcf
label: tbtamr_fq2vcf
doc: "Generates a VCF file from FASTQ reads using mutAMR.\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: reference_fasta
    type: File
    doc: Path to the reference FASTA file.
    inputBinding:
      position: 1
  - id: append_fasta_fastq_comment
    type:
      - 'null'
      - boolean
    doc: Append FASTA/FASTQ comment to SAM output in BWA.
    inputBinding:
      position: 102
      prefix: --append-fasta-fastq-comment
  - id: band_width
    type:
      - 'null'
      - int
    doc: Band width for banded alignment in BWA.
    inputBinding:
      position: 102
      prefix: --band-width
  - id: discard_short_seeded_bases
    type:
      - 'null'
      - int
    doc: Discard a chain if seeded bases shorter than INT in BWA.
    inputBinding:
      position: 102
      prefix: --discard-short-seeded-bases
  - id: dont_modify_mapq_supplementary
    type:
      - 'null'
      - boolean
    doc: Don't modify mapQ of supplementary alignments in BWA.
    inputBinding:
      position: 102
      prefix: --dont-modify-mapq-supplementary
  - id: drop_chains_fraction
    type:
      - 'null'
      - float
    doc: Drop chains shorter than FLOAT fraction of the longest overlapping 
      chain in BWA.
    inputBinding:
      position: 102
      prefix: --drop-chains-fraction
  - id: end_clipping_penalty
    type:
      - 'null'
      - string
    doc: Penalty for 5'- and 3'-end clipping in BWA.
    inputBinding:
      position: 102
      prefix: --end-clipping-penalty
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: Gap extension penalty in BWA.
    inputBinding:
      position: 102
      prefix: --gap-extension-penalty
  - id: gap_open_penalties
    type:
      - 'null'
      - string
    doc: Gap open penalties for deletions and insertions in BWA.
    inputBinding:
      position: 102
      prefix: --gap-open-penalties
  - id: insert_header_string_or_file
    type:
      - 'null'
      - string
    doc: Insert STR to header if it starts with @; or insert lines in FILE in 
      BWA.
    inputBinding:
      position: 102
      prefix: --insert-header-string-or-file
  - id: insert_size_distribution
    type:
      - 'null'
      - string
    doc: Specify the mean, standard deviation, max, and min of the insert size 
      distribution for BWA.
    inputBinding:
      position: 102
      prefix: --insert-size-distribution
  - id: mark_shorter_split_hits_secondary
    type:
      - 'null'
      - boolean
    doc: Mark shorter split hits as secondary in BWA.
    inputBinding:
      position: 102
      prefix: --mark-shorter-split-hits-secondary
  - id: match_score
    type:
      - 'null'
      - int
    doc: Score for a sequence match in BWA.
    inputBinding:
      position: 102
      prefix: --match-score
  - id: max_mate_rescues
    type:
      - 'null'
      - int
    doc: Perform at most INT rounds of mate rescues for each read in BWA.
    inputBinding:
      position: 102
      prefix: --max-mate-rescues
  - id: max_score_fraction_XA
    type:
      - 'null'
      - float
    doc: The fraction of the max score to use with -h in BWA.
    inputBinding:
      position: 102
      prefix: --max-score-fraction-XA
  - id: min_score_output
    type:
      - 'null'
      - int
    doc: Minimum score to output in BWA.
    inputBinding:
      position: 102
      prefix: --min-score-output
  - id: min_seed_length
    type:
      - 'null'
      - int
    doc: Minimum seed length for BWA.
    inputBinding:
      position: 102
      prefix: --min-seed-length
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a mismatch in BWA.
    inputBinding:
      position: 102
      prefix: --mismatch-penalty
  - id: off_diagonal_xdropoff
    type:
      - 'null'
      - int
    doc: Off-diagonal X-dropoff for BWA.
    inputBinding:
      position: 102
      prefix: --off-diagonal-xdropoff
  - id: output_all_alignments_SE_PE
    type:
      - 'null'
      - boolean
    doc: Output all alignments for SE or unpaired PE in BWA.
    inputBinding:
      position: 102
      prefix: --output-all-alignments-SE-PE
  - id: output_all_hits_XA
    type:
      - 'null'
      - string
    doc: If there are <INT hits with score >80.00% of the max score, output all 
      in XA in BWA.
    inputBinding:
      position: 102
      prefix: --output-all-hits-XA
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to store output files.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_reference_header_XR
    type:
      - 'null'
      - boolean
    doc: Output the reference FASTA header in the XR tag in BWA.
    inputBinding:
      position: 102
      prefix: --output-reference-header-XR
  - id: output_xb_instead_of_xa
    type:
      - 'null'
      - boolean
    doc: Output XB instead of XA in BWA; XB is XA with the alignment score and 
      mapping quality added.
    inputBinding:
      position: 102
      prefix: --output-xb-instead-of-xa
  - id: process_input_bases_batch
    type:
      - 'null'
      - int
    doc: Process INT input bases in each batch regardless of nThreads in BWA.
    inputBinding:
      position: 102
      prefix: --process-input-bases-batch
  - id: read_group_header
    type:
      - 'null'
      - string
    doc: Read group header line for BWA (e.g., '@RG\tID:foo\tSM:bar').
    inputBinding:
      position: 102
      prefix: --read-group-header
  - id: read_type
    type:
      - 'null'
      - string
    doc: Read type for BWA (e.g., pacbio, ont2d, intractg).
    inputBinding:
      position: 102
      prefix: --read-type
  - id: samclip_max_length
    type:
      - 'null'
      - int
    doc: Maximum length for samclip.
    inputBinding:
      position: 102
      prefix: --samclip-max-length
  - id: samtools_fixmate_mode
    type:
      - 'null'
      - string
    doc: Mode for samtools fixmate.
    inputBinding:
      position: 102
      prefix: --samtools-fixmate-mode
  - id: samtools_markdup_remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicates with samtools markdup.
    inputBinding:
      position: 102
      prefix: --samtools-markdup-remove-duplicates
  - id: samtools_markdup_skip_reads
    type:
      - 'null'
      - boolean
    doc: Skip reads with samtools markdup.
    inputBinding:
      position: 102
      prefix: --samtools-markdup-skip-reads
  - id: samtools_markdup_temp_prefix
    type:
      - 'null'
      - string
    doc: Temporary file prefix for samtools markdup.
    inputBinding:
      position: 102
      prefix: --samtools-markdup-temp-prefix
  - id: samtools_sort_level
    type:
      - 'null'
      - int
    doc: Compression level for samtools sort.
    inputBinding:
      position: 102
      prefix: --samtools-sort-level
  - id: samtools_sort_memory
    type:
      - 'null'
      - string
    doc: Memory per thread for samtools sort.
    inputBinding:
      position: 102
      prefix: --samtools-sort-memory
  - id: samtools_sort_n
    type:
      - 'null'
      - boolean
    doc: Use -n option for samtools sort (sort by read name).
    inputBinding:
      position: 102
      prefix: --samtools-sort-n
  - id: samtools_sort_temp_prefix
    type:
      - 'null'
      - string
    doc: Temporary file prefix for samtools sort.
    inputBinding:
      position: 102
      prefix: --samtools-sort-temp-prefix
  - id: seed_occurrence_ratio
    type:
      - 'null'
      - float
    doc: Seed occurrence ratio for BWA.
    inputBinding:
      position: 102
      prefix: --seed-occurrence-ratio
  - id: seed_occurrence_third_round
    type:
      - 'null'
      - int
    doc: Seed occurrence for the 3rd round seeding in BWA.
    inputBinding:
      position: 102
      prefix: --seed-occurrence-third-round
  - id: skip_mate_rescue
    type:
      - 'null'
      - boolean
    doc: Skip mate rescue in BWA.
    inputBinding:
      position: 102
      prefix: --skip-mate-rescue
  - id: skip_pairing
    type:
      - 'null'
      - boolean
    doc: Skip pairing; mate rescue performed unless -S also in use in BWA.
    inputBinding:
      position: 102
      prefix: --skip-pairing
  - id: skip_seeds_occurrence
    type:
      - 'null'
      - int
    doc: Skip seeds with more than INT occurrences in BWA.
    inputBinding:
      position: 102
      prefix: --skip-seeds-occurrence
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: Smart pairing in BWA (ignoring in2.fq).
    inputBinding:
      position: 102
      prefix: --smart-pairing
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BWA and Samtools.
    inputBinding:
      position: 102
      prefix: --threads
  - id: treat_alt_contigs_as_primary
    type:
      - 'null'
      - boolean
    doc: Treat ALT contigs as part of the primary assembly in BWA.
    inputBinding:
      position: 102
      prefix: --treat-alt-contigs-as-primary
  - id: unpaired_read_pair_penalty
    type:
      - 'null'
      - int
    doc: Penalty for an unpaired read pair in BWA.
    inputBinding:
      position: 102
      prefix: --unpaired-read-pair-penalty
  - id: use_smallest_query_coordinate
    type:
      - 'null'
      - boolean
    doc: For split alignment, take the alignment with the smallest query (not 
      genomic) coordinate as primary in BWA.
    inputBinding:
      position: 102
      prefix: --use-smallest-query-coordinate
  - id: use_soft_clipping_supplementary
    type:
      - 'null'
      - boolean
    doc: Use soft clipping for supplementary alignments in BWA.
    inputBinding:
      position: 102
      prefix: --use-soft-clipping-supplementary
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: Verbosity level for BWA (1=error, 2=warning, 3=message, 4+=debugging).
    inputBinding:
      position: 102
      prefix: --verbosity-level
outputs:
  - id: output_sam_file
    type:
      - 'null'
      - File
    doc: Sam file to output results to in BWA.
    outputBinding:
      glob: $(inputs.output_sam_file)
  - id: output_bam_file
    type:
      - 'null'
      - File
    doc: Output BAM file name.
    outputBinding:
      glob: $(inputs.output_bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
