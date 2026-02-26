cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr_full
label: tbtamr_full
doc: "Runs the full tbtamr pipeline, including mutAMR for VCF generation and BWA MEM
  for alignment.\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file for BWA indexing
    inputBinding:
      position: 1
  - id: input_reads_1
    type: File
    doc: First FASTQ file of paired-end reads
    inputBinding:
      position: 2
  - id: input_reads_2
    type:
      - 'null'
      - File
    doc: Second FASTQ file of paired-end reads
    inputBinding:
      position: 3
  - id: append_fasta_fastq_comment
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
  - id: discard_seeded_bases_shorter_than
    type:
      - 'null'
      - int
    doc: discard a chain if seeded bases shorter than INT
    default: 0
    inputBinding:
      position: 104
      prefix: -W
  - id: dont_modify_mapq_supplementary
    type:
      - 'null'
      - boolean
    doc: don't modify mapQ of supplementary alignments
    inputBinding:
      position: 104
      prefix: -q
  - id: drop_chains_fraction
    type:
      - 'null'
      - float
    doc: drop chains shorter than FLOAT fraction of the longest overlapping 
      chain
    default: 0.5
    inputBinding:
      position: 104
      prefix: -D
  - id: end_clipping_penalty
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
    doc: gap extension penalty; a gap of size k cost '{-O} + {-E}*k'
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalties
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
    doc: specify the mean, standard deviation (10% of the mean if absent), max 
      (4 sigma from the mean if absent) and min of the insert size distribution.
      FR orientation only.
    inputBinding:
      position: 104
      prefix: -I
  - id: mark_shorter_split_hits_secondary
    type:
      - 'null'
      - boolean
    doc: mark shorter split hits as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: max_clip_length
    type:
      - 'null'
      - int
    doc: Maximum clipping length for samclip
    default: 10
    inputBinding:
      position: 104
      prefix: --max-clip-length
  - id: max_mate_rescues
    type:
      - 'null'
      - int
    doc: perform at most INT rounds of mate rescues for each read
    default: 50
    inputBinding:
      position: 104
      prefix: -m
  - id: max_score_fraction_h
    type:
      - 'null'
      - float
    doc: The fraction of the max score to use with -h
    default: 0.8
    inputBinding:
      position: 104
      prefix: -z
  - id: memory_samtools_sort
    type:
      - 'null'
      - string
    doc: Memory per thread for samtools sort
    default: 1000M
    inputBinding:
      position: 104
      prefix: --memory-samtools-sort
  - id: min_score_output
    type:
      - 'null'
      - int
    doc: minimum score to output
    default: 50
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
  - id: off_diagonal_x_dropoff
    type:
      - 'null'
      - int
    doc: off-diagonal X-dropoff
    default: 100
    inputBinding:
      position: 104
      prefix: -d
  - id: output_all_hits_xa
    type:
      - 'null'
      - string
    doc: if there are <INT hits with score >80.00% of the max score, output all 
      in XA
    inputBinding:
      position: 104
      prefix: -h
  - id: output_all_se_unpaired_pe
    type:
      - 'null'
      - boolean
    doc: output all alignments for SE or unpaired PE
    inputBinding:
      position: 104
      prefix: -a
  - id: output_reference_header_xr
    type:
      - 'null'
      - boolean
    doc: output the reference FASTA header in the XR tag
    inputBinding:
      position: 104
      prefix: -V
  - id: output_xb_instead_of_xa
    type:
      - 'null'
      - boolean
    doc: output XB instead of XA; XB is XA with the alignment score and mapping 
      quality added.
    inputBinding:
      position: 104
      prefix: -u
  - id: process_input_bases_batch
    type:
      - 'null'
      - int
    doc: process INT input bases in each batch regardless of nThreads (for 
      reproducibility)
    inputBinding:
      position: 104
      prefix: -K
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
    doc: read type. Setting -x changes multiple parameters unless overridden
    inputBinding:
      position: 104
      prefix: -x
  - id: reference_catalog
    type:
      - 'null'
      - File
    doc: Path to the reference catalog file
    inputBinding:
      position: 104
      prefix: --reference-catalog
  - id: seed_occurrence_factor
    type:
      - 'null'
      - float
    doc: look for internal seeds inside a seed longer than {-k} * FLOAT
    default: 1.5
    inputBinding:
      position: 104
      prefix: -r
  - id: seed_occurrence_third_round
    type:
      - 'null'
      - int
    doc: seed occurrence for the 3rd round seeding
    default: 20
    inputBinding:
      position: 104
      prefix: -y
  - id: sequence_match_score
    type:
      - 'null'
      - int
    doc: score for a sequence match, which scales options -TdBOELU unless 
      overridden
    default: 1
    inputBinding:
      position: 104
      prefix: -A
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
    default: 500
    inputBinding:
      position: 104
      prefix: -c
  - id: smart_pairing
    type:
      - 'null'
      - boolean
    doc: smart pairing (ignoring in2.fq)
    inputBinding:
      position: 104
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 8
    inputBinding:
      position: 104
      prefix: --threads
  - id: threads_samclip
    type:
      - 'null'
      - int
    doc: Number of threads for samclip
    inputBinding:
      position: 104
      prefix: --threads-samclip
  - id: threads_samtools_fixmate
    type:
      - 'null'
      - int
    doc: Number of threads for samtools fixmate
    inputBinding:
      position: 104
      prefix: --threads-samtools-fixmate
  - id: threads_samtools_markdup
    type:
      - 'null'
      - int
    doc: Number of threads for samtools markdup
    inputBinding:
      position: 104
      prefix: --threads-samtools-markdup
  - id: threads_samtools_sort
    type:
      - 'null'
      - int
    doc: Number of threads for samtools sort
    default: 8
    inputBinding:
      position: 104
      prefix: --threads-samtools-sort
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for samtools operations
    default: /tmp
    inputBinding:
      position: 104
      prefix: --tmp-dir
  - id: treat_alt_contigs_as_primary
    type:
      - 'null'
      - boolean
    doc: treat ALT contigs as part of the primary assembly (i.e. ignore 
      <idxbase>.alt file)
    inputBinding:
      position: 104
      prefix: -j
  - id: unpaired_read_pair_penalty
    type:
      - 'null'
      - int
    doc: penalty for an unpaired read pair
    default: 17
    inputBinding:
      position: 104
      prefix: -U
  - id: use_smallest_query_coordinate
    type:
      - 'null'
      - boolean
    doc: for split alignment, take the alignment with the smallest query (not 
      genomic) coordinate as primary
    inputBinding:
      position: 104
      prefix: '-5'
  - id: use_soft_clipping_supplementary
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'verbosity level: 1=error, 2=warning, 3=message, 4+=debugging'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_sam_file
    type:
      - 'null'
      - File
    doc: sam file to output results to
    outputBinding:
      glob: $(inputs.output_sam_file)
  - id: output_bam_file
    type:
      - 'null'
      - File
    doc: Path to the output BAM file
    outputBinding:
      glob: $(inputs.output_bam_file)
  - id: output_vcf_file
    type:
      - 'null'
      - File
    doc: Path to the output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
