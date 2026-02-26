cwlVersion: v1.2
class: CommandLineTool
baseCommand: dragenos
label: narfmap_dragen-os
doc: "Command line options:\n\nTool homepage: https://github.com/Emiller88/NARFMAP"
inputs:
  - id: reference
    type: string
    doc: reference
    inputBinding:
      position: 1
  - id: base_calls
    type: string
    doc: base calls
    inputBinding:
      position: 2
  - id: bam_input
    type:
      - 'null'
      - File
    doc: Input BAM file
    inputBinding:
      position: 103
      prefix: --bam-input
  - id: build_hash_table
    type:
      - 'null'
      - int
    doc: Generate a reference/hash table
    default: 0
    inputBinding:
      position: 103
      prefix: --build-hash-table
  - id: enable_sampling
    type:
      - 'null'
      - int
    doc: Automatically detect paired-end parameters by running a sample through 
      the mapper/aligner
    default: 1
    inputBinding:
      position: 103
      prefix: --enable-sampling
  - id: fastq_file1
    type:
      - 'null'
      - File
    doc: FASTQ file to send to card (may be gzipped)
    inputBinding:
      position: 103
      prefix: --fastq-file1
  - id: fastq_file2
    type:
      - 'null'
      - File
    doc: Second FASTQ file with paired-end reads (may be gzipped)
    inputBinding:
      position: 103
      prefix: --fastq-file2
  - id: fastq_offset
    type:
      - 'null'
      - int
    doc: FASTQ quality offset value. Set to 33 or 64
    default: 33
    inputBinding:
      position: 103
      prefix: --fastq-offset
  - id: filter_len_ratio
    type:
      - 'null'
      - float
    doc: Ratio for controlling seed chain filtering
    default: 4
    inputBinding:
      position: 103
      prefix: --Mapper.filter-len-ratio
  - id: help_defaults
    type:
      - 'null'
      - boolean
    doc: produce tab-delimited list of command line options and their default 
      values
    inputBinding:
      position: 103
      prefix: --help-defaults
  - id: ht_anchor_bin_bits
    type:
      - 'null'
      - int
    doc: Bits defining reference bins for anchored seed search
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-anchor-bin-bits
  - id: ht_cost_coeff_seed_freq
    type:
      - 'null'
      - float
    doc: Cost coefficient of extended seed frequency
    default: 0.5
    inputBinding:
      position: 103
      prefix: --ht-cost-coeff-seed-freq
  - id: ht_cost_coeff_seed_len
    type:
      - 'null'
      - float
    doc: Cost coefficient of extended seed length
    default: 1
    inputBinding:
      position: 103
      prefix: --ht-cost-coeff-seed-len
  - id: ht_cost_penalty
    type:
      - 'null'
      - float
    doc: Cost penalty to extend a seed by any number of bases
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-cost-penalty
  - id: ht_cost_penalty_incr
    type:
      - 'null'
      - float
    doc: Cost penalty to incrementally extend a seed another step
    default: 0.7
    inputBinding:
      position: 103
      prefix: --ht-cost-penalty-incr
  - id: ht_crc_extended
    type:
      - 'null'
      - int
    doc: Index of CRC polynomial for hashing extended seeds
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-crc-extended
  - id: ht_crc_primary
    type:
      - 'null'
      - int
    doc: Index of CRC polynomial for hashing primary seeds
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-crc-primary
  - id: ht_decoys
    type:
      - 'null'
      - File
    doc: Path to decoys file (FASTA format)
    inputBinding:
      position: 103
      prefix: --ht-decoys
  - id: ht_dump_int_params
    type:
      - 'null'
      - int
    doc: Testing - dump internal parameters
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-dump-int-params
  - id: ht_ext_rec_cost
    type:
      - 'null'
      - int
    doc: Cost penalty for each EXTEND or INTERVAL record
    default: 4
    inputBinding:
      position: 103
      prefix: --ht-ext-rec-cost
  - id: ht_ext_table_alloc
    type:
      - 'null'
      - int
    doc: 8-byte records to reserve in extend_table.bin (0=automatic)
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-ext-table-alloc
  - id: ht_mask_bed
    type:
      - 'null'
      - File
    doc: Bed file for base masking
    inputBinding:
      position: 103
      prefix: --ht-mask-bed
  - id: ht_max_dec_factor
    type:
      - 'null'
      - int
    doc: Maximum decimation factor for seed thinning
    default: 1
    inputBinding:
      position: 103
      prefix: --ht-max-dec-factor
  - id: ht_max_ext_incr
    type:
      - 'null'
      - int
    doc: Maximum bases to extend a seed by in one step
    default: 12
    inputBinding:
      position: 103
      prefix: --ht-max-ext-incr
  - id: ht_max_ext_seed_len
    type:
      - 'null'
      - int
    doc: Maximum extended seed length
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-max-ext-seed-len
  - id: ht_max_multi_base_seeds
    type:
      - 'null'
      - int
    doc: Maximum seeds populated at multi-base codes
    inputBinding:
      position: 103
      prefix: --ht-max-multi-base-seeds
  - id: ht_max_seed_freq
    type:
      - 'null'
      - int
    doc: Maximum allowed frequency for a seed match after extension attempts
    default: 16
    inputBinding:
      position: 103
      prefix: --ht-max-seed-freq
  - id: ht_max_seed_freq_len
    type:
      - 'null'
      - int
    doc: Ramp from priMaxSeedFreq reaches maxSeedFreq at this seed length
    default: 98
    inputBinding:
      position: 103
      prefix: --ht-max-seed-freq-len
  - id: ht_max_table_chunks
    type:
      - 'null'
      - int
    doc: Maximum ~1GB thread table chunks in memory at once
    inputBinding:
      position: 103
      prefix: --ht-max-table-chunks
  - id: ht_mem_limit
    type:
      - 'null'
      - string
    doc: Memory limit (hash table + reference)
    default: 0GB
    inputBinding:
      position: 103
      prefix: --ht-mem-limit
  - id: ht_methylated
    type:
      - 'null'
      - int
    doc: If set to true, generate C->T and G->A converted pair of hashtables
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-methylated
  - id: ht_min_repair_prob
    type:
      - 'null'
      - float
    doc: Minimum probability of success to attempt extended seed repair
    default: 0.2
    inputBinding:
      position: 103
      prefix: --ht-min-repair-prob
  - id: ht_num_threads
    type:
      - 'null'
      - int
    doc: Worker threads for generating hash table
    inputBinding:
      position: 103
      prefix: --ht-num-threads
  - id: ht_override_size_check
    type:
      - 'null'
      - int
    doc: Override hash table size check
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-override-size-check
  - id: ht_pri_max_seed_freq
    type:
      - 'null'
      - int
    doc: Maximum frequency for a primary seed match (0 => use maxSeedFreq)
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-pri-max-seed-freq
  - id: ht_rand_hit_extend
    type:
      - 'null'
      - int
    doc: Include a random hit with each EXTEND record of this frequency
    default: 8
    inputBinding:
      position: 103
      prefix: --ht-rand-hit-extend
  - id: ht_rand_hit_hifreq
    type:
      - 'null'
      - int
    doc: Include a random hit with each HIFREQ record
    default: 1
    inputBinding:
      position: 103
      prefix: --ht-rand-hit-hifreq
  - id: ht_ref_seed_interval
    type:
      - 'null'
      - int
    doc: Number of positions per reference seed
    inputBinding:
      position: 103
      prefix: --ht-ref-seed-interval
  - id: ht_reference
    type:
      - 'null'
      - File
    doc: Reference in FASTA format
    inputBinding:
      position: 103
      prefix: --ht-reference
  - id: ht_repair_strategy
    type:
      - 'null'
      - int
    doc: 'Seed extension repair strategy: 0=none, 1=best, 2=rand'
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-repair-strategy
  - id: ht_seed_len
    type:
      - 'null'
      - int
    doc: Initial seed length to store in hash table
    default: 21
    inputBinding:
      position: 103
      prefix: --ht-seed-len
  - id: ht_size
    type:
      - 'null'
      - string
    doc: Size of hash table, units B|KB|MB|GB
    default: 0GB
    inputBinding:
      position: 103
      prefix: --ht-size
  - id: ht_sj_size
    type:
      - 'null'
      - string
    doc: Reserved space for RNA annotated SJs, units B|KB|MB|GB
    inputBinding:
      position: 103
      prefix: --ht-sj-size
  - id: ht_soft_seed_freq_cap
    type:
      - 'null'
      - int
    doc: Soft seed frequency cap for thinning
    default: 12
    inputBinding:
      position: 103
      prefix: --ht-soft-seed-freq-cap
  - id: ht_target_seed_freq
    type:
      - 'null'
      - int
    doc: Target seed frequency for seed extension
    default: 4
    inputBinding:
      position: 103
      prefix: --ht-target-seed-freq
  - id: ht_test_only
    type:
      - 'null'
      - int
    doc: Testing - show user parameters, but don't do anything
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-test-only
  - id: ht_uncompress
    type:
      - 'null'
      - int
    doc: Uncompress hash_table.cmp to hash_table.bin and extend_table.bin 
      (standalone option)
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-uncompress
  - id: ht_write_hash_bin
    type:
      - 'null'
      - int
    doc: Write decompressed hash_table.bin and extend_table.bin (0/1)
    default: 0
    inputBinding:
      position: 103
      prefix: --ht-write-hash-bin
  - id: input_qname_suffix_delimiter
    type:
      - 'null'
      - string
    doc: Character that delimits input qname suffixes, e.g. / for /1
    default: ' '
    inputBinding:
      position: 103
      prefix: --input-qname-suffix-delimiter
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved paired-end reads in single bam or FASTQ
    default: false
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: map_only
    type:
      - 'null'
      - int
    doc: no real alignment, produces alignment information based on seed chains 
      only
    default: 0
    inputBinding:
      position: 103
      prefix: --map-only
  - id: mmap_reference
    type:
      - 'null'
      - int
    doc: memory-map reference data instead of pre-loading. This allows for 
      quicker runs when only a handful of reads need to be aligned
    default: 0
    inputBinding:
      position: 103
      prefix: --mmap-reference
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Worker threads for mapper/aligner (default = maximum available on 
      system)
    default: 20
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --output-directory
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: Output filename prefix
    inputBinding:
      position: 103
      prefix: --output-file-prefix
  - id: pe_orientation
    type:
      - 'null'
      - string
    doc: 'Expected paired-end orientation: 0=FR, 1=RF, 2=FF'
    inputBinding:
      position: 103
      prefix: --Aligner.pe-orientation
  - id: pe_stat_mean_insert
    type:
      - 'null'
      - float
    doc: Expected mean of the insert size
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.pe-stat-mean-insert
  - id: pe_stat_mean_read_len
    type:
      - 'null'
      - float
    doc: When setting paired-end insert stats, the expected mean read length
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.pe-stat-mean-read-len
  - id: pe_stat_quartiles_insert
    type:
      - 'null'
      - string
    doc: Q25, Q50, and Q75 quartiles for the insert size
    inputBinding:
      position: 103
      prefix: --Aligner.pe-stat-quartiles-insert
  - id: pe_stat_stddev_insert
    type:
      - 'null'
      - float
    doc: Expected standard deviation of the insert size
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.pe-stat-stddev-insert
  - id: pe_stats_interval_delay
    type:
      - 'null'
      - string
    doc: Number of intervals of lag between sending reads and using resulting 
      stats
    inputBinding:
      position: 103
      prefix: --pe-stats-interval-delay
  - id: pe_stats_interval_memory
    type:
      - 'null'
      - string
    doc: Include reads from up to this many stats intervals in paired-end stats 
      calculations
    inputBinding:
      position: 103
      prefix: --pe-stats-interval-memory
  - id: pe_stats_interval_size
    type:
      - 'null'
      - int
    doc: Number of reads to include in each interval of updating paired-end 
      stats
    default: 25000
    inputBinding:
      position: 103
      prefix: --pe-stats-interval-size
  - id: pe_stats_sample_size
    type:
      - 'null'
      - int
    doc: Number of most recent pairs to include in each update of the paired-end
      stats
    default: 100000
    inputBinding:
      position: 103
      prefix: --pe-stats-sample-size
  - id: preserve_map_align_order
    type:
      - 'null'
      - int
    doc: Preserve the order of mapper/aligner output to produce deterministic 
      results. Impacts performance
    default: 0
    inputBinding:
      position: 103
      prefix: --preserve-map-align-order
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: directory with reference and hash tables. Must contain the uncompressed
      hashtable.
    inputBinding:
      position: 103
      prefix: --ref-dir
  - id: ref_load_hash_bin
    type:
      - 'null'
      - int
    doc: Expect to find uncompressed hash table in the reference directory.
    default: 0
    inputBinding:
      position: 103
      prefix: --ref-load-hash-bin
  - id: rescue_ceil_factor
    type:
      - 'null'
      - float
    doc: For tuning the rescue scan window maximum ceiling
    default: 3
    inputBinding:
      position: 103
      prefix: --Aligner.rescue-ceil-factor
  - id: rescue_sigmas
    type:
      - 'null'
      - float
    doc: For tuning the rescue scan window
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.rescue-sigmas
  - id: response_file
    type:
      - 'null'
      - File
    doc: file with more command line arguments
    inputBinding:
      position: 103
      prefix: --response-file
  - id: rgid
    type:
      - 'null'
      - int
    doc: Read Group ID
    default: 1
    inputBinding:
      position: 103
      prefix: --RGID
  - id: rgsm
    type:
      - 'null'
      - string
    doc: Read Group Sample
    default: none
    inputBinding:
      position: 103
      prefix: --RGSM
  - id: sec_aligns
    type:
      - 'null'
      - int
    doc: Maximum secondary (suboptimal) alignments to report per read
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.sec-aligns
  - id: sec_aligns_hard
    type:
      - 'null'
      - int
    doc: Set to force unmapped when not all secondary alignments can be output
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.sec-aligns-hard
  - id: sec_phred_delta
    type:
      - 'null'
      - float
    doc: Only secondary alignments with likelihood within this phred of the 
      primary
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.sec-phred-delta
  - id: sec_score_delta
    type:
      - 'null'
      - float
    doc: Secondary aligns allowed with pair score no more than this far below 
      primary
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.sec-score-delta
  - id: smith_waterman_method
    type:
      - 'null'
      - string
    doc: SmithWaterman implementation (dragen / mengyao default = dragen)
    default: dragen
    inputBinding:
      position: 103
      prefix: --Aligner.smith-waterman-method
  - id: sw_all
    type:
      - 'null'
      - int
    doc: Value of 1 forces smith waterman on all candidate alignments
    default: 0
    inputBinding:
      position: 103
      prefix: --Aligner.sw-all
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be talkative
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/narfmap:1.4.2--h43eeafb_3
stdout: narfmap_dragen-os.out
