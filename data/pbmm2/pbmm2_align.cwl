cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbmm2
  - align
label: pbmm2_align
doc: "Align PacBio reads to reference sequences\n\nTool homepage: https://github.com/PacificBiosciences/pbmm2"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA, ReferenceSet XML, or Reference Index
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input BAM, DataSet XML, FASTA, or FASTQ
    inputBinding:
      position: 2
  - id: bam_index
    type:
      - 'null'
      - string
    doc: 'Generate index for sorted BAM output. Valid choices: (NONE, BAI, CSI).'
    inputBinding:
      position: 103
      prefix: --bam-index
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Bandwidth used in chaining and DP-based alignment.
    inputBinding:
      position: 103
      prefix: -r
  - id: best_n
    type:
      - 'null'
      - int
    doc: Output at maximum N alignments for each read, 0 means no maximum.
    inputBinding:
      position: 103
      prefix: --best-n
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Process N records per chunk.
    inputBinding:
      position: 103
      prefix: --chunk-size
  - id: collapse_homopolymers
    type:
      - 'null'
      - boolean
    doc: Collapse homopolymers in reads and reference.
    inputBinding:
      position: 103
      prefix: --collapse-homopolymers
  - id: gap_extend_1
    type:
      - 'null'
      - int
    doc: Gap extension penalty 1.
    inputBinding:
      position: 103
      prefix: --gap-extend-1
  - id: gap_extend_2
    type:
      - 'null'
      - int
    doc: Gap extension penalty 2.
    inputBinding:
      position: 103
      prefix: --gap-extend-2
  - id: gap_open_1
    type:
      - 'null'
      - int
    doc: Gap open penalty 1.
    inputBinding:
      position: 103
      prefix: --gap-open-1
  - id: gap_open_2
    type:
      - 'null'
      - int
    doc: Gap open penalty 2.
    inputBinding:
      position: 103
      prefix: --gap-open-2
  - id: hqregion
    type:
      - 'null'
      - boolean
    doc: Process HQ region of each ZMW, subreadset.xml input required (activates UNROLLED
      preset).
    inputBinding:
      position: 103
      prefix: --hqregion
  - id: include_fail_reads
    type:
      - 'null'
      - boolean
    doc: Align fail reads. Only for consensusreadset.xml input.
    inputBinding:
      position: 103
      prefix: --include-fail-reads
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28).
    inputBinding:
      position: 103
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: matching_score
    type:
      - 'null'
      - int
    doc: Matching score.
    inputBinding:
      position: 103
      prefix: -A
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: Max intron length (changes -r).
    inputBinding:
      position: 103
      prefix: -G
  - id: median_filter
    type:
      - 'null'
      - boolean
    doc: Pick one read per ZMW of median length.
    inputBinding:
      position: 103
      prefix: --median-filter
  - id: min_gap_comp_id_perc
    type:
      - 'null'
      - float
    doc: Minimum gap-compressed sequence identity in percent.
    inputBinding:
      position: 103
      prefix: --min-gap-comp-id-perc
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum mapped read length in basepairs.
    inputBinding:
      position: 103
      prefix: --min-length
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size.
    inputBinding:
      position: 103
      prefix: -w
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatch penalty.
    inputBinding:
      position: 103
      prefix: -B
  - id: no_kmer_compression
    type:
      - 'null'
      - boolean
    doc: Disable homopolymer-compressed k-mer (compression is active for SUBREAD &
      UNROLLED presets).
    inputBinding:
      position: 103
      prefix: --no-kmer-compression
  - id: no_splice_flank
    type:
      - 'null'
      - boolean
    doc: Do not prefer splice flanks GT-AG (effective in ISOSEQ preset).
    inputBinding:
      position: 103
      prefix: --no-splice-flank
  - id: non_canonical_splicing_cost
    type:
      - 'null'
      - int
    doc: Cost for a non-canonical GT-AG splicing (effective in ISOSEQ preset).
    inputBinding:
      position: 103
      prefix: -C
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Set alignment mode. Valid choices: (SUBREAD, CCS, HIFI, ISOSEQ, UNROLLED).'
    inputBinding:
      position: 103
      prefix: --preset
  - id: read_group
    type:
      - 'null'
      - string
    doc: Read group header line such as '@RG\tID:xyz\tSM:abc'. Only for FASTA/Q inputs.
    inputBinding:
      position: 103
      prefix: --rg
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name for all read groups.
    inputBinding:
      position: 103
      prefix: --sample
  - id: short_sa_cigar
    type:
      - 'null'
      - boolean
    doc: Populate SA tag with short cigar representation.
    inputBinding:
      position: 103
      prefix: --short-sa-cigar
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Generate sorted BAM file.
    inputBinding:
      position: 103
      prefix: --sort
  - id: sort_memory
    type:
      - 'null'
      - string
    doc: Memory per thread for sorting.
    inputBinding:
      position: 103
      prefix: --sort-memory
  - id: sort_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for sorting; 0 means 25% of -j, maximum 8.
    inputBinding:
      position: 103
      prefix: --sort-threads
  - id: split_by_sample
    type:
      - 'null'
      - boolean
    doc: One output BAM per sample.
    inputBinding:
      position: 103
      prefix: --split-by-sample
  - id: stop_chain_elongation
    type:
      - 'null'
      - int
    doc: Stop chain enlongation if there are no minimizers in N bp.
    inputBinding:
      position: 103
      prefix: -g
  - id: strip
    type:
      - 'null'
      - boolean
    doc: Remove all kinetic and extra QV tags. Output cannot be polished.
    inputBinding:
      position: 103
      prefix: --strip
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Include unmapped records in output.
    inputBinding:
      position: 103
      prefix: --unmapped
  - id: z_drop_inversion_score
    type:
      - 'null'
      - int
    doc: Z-drop inversion score.
    inputBinding:
      position: 103
      prefix: -Z
  - id: z_drop_score
    type:
      - 'null'
      - int
    doc: Z-drop score.
    inputBinding:
      position: 103
      prefix: -z
  - id: zmw
    type:
      - 'null'
      - boolean
    doc: Process ZMW Reads, subreadset.xml input required (activates UNROLLED preset).
    inputBinding:
      position: 103
      prefix: --zmw
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BAM or DataSet XML
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbmm2:26.1.0--h9ee0642_0
