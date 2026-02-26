cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - bcbio-variation-standalone.jar
label: bcbio-variation
doc: "The Genome Analysis Toolkit (GATK) v3.2-12-g034abb9\n\nTool homepage: https://github.com/chapmanb/bcbio.variation"
inputs:
  - id: allow_potentially_misencoded_quality_scores
    type:
      - 'null'
      - boolean
    doc: Ignore warnings about base quality score encoding
    inputBinding:
      position: 101
      prefix: --allow_potentially_misencoded_quality_scores
  - id: analysis_type
    type: string
    doc: Name of the tool to run
    inputBinding:
      position: 101
      prefix: --analysis_type
  - id: arg_file
    type:
      - 'null'
      - File
    doc: Reads arguments from the specified file
    inputBinding:
      position: 101
      prefix: --arg_file
  - id: baq
    type:
      - 'null'
      - string
    doc: Type of BAQ calculation to apply in the engine 
      (OFF|CALCULATE_AS_NECESSARY|RECALCULATE)
    inputBinding:
      position: 101
      prefix: --baq
  - id: baq_gap_open_penalty
    type:
      - 'null'
      - float
    doc: BAQ gap open penalty
    inputBinding:
      position: 101
      prefix: --baqGapOpenPenalty
  - id: bqsr
    type:
      - 'null'
      - File
    doc: Input covariates table file for on-the-fly base quality score 
      recalibration
    inputBinding:
      position: 101
      prefix: --BQSR
  - id: default_base_qualities
    type:
      - 'null'
      - int
    doc: Assign a default base quality
    inputBinding:
      position: 101
      prefix: --defaultBaseQualities
  - id: disable_indel_quals
    type:
      - 'null'
      - boolean
    doc: Disable printing of base insertion and deletion tags (with -BQSR)
    inputBinding:
      position: 101
      prefix: --disable_indel_quals
  - id: downsample_to_coverage
    type:
      - 'null'
      - int
    doc: Target coverage threshold for downsampling to coverage
    inputBinding:
      position: 101
      prefix: --downsample_to_coverage
  - id: downsample_to_fraction
    type:
      - 'null'
      - float
    doc: Fraction of reads to downsample to
    inputBinding:
      position: 101
      prefix: --downsample_to_fraction
  - id: downsampling_type
    type:
      - 'null'
      - string
    doc: Type of read downsampling to employ at a given locus 
      (NONE|ALL_READS|BY_SAMPLE)
    inputBinding:
      position: 101
      prefix: --downsampling_type
  - id: emit_original_quals
    type:
      - 'null'
      - boolean
    doc: Emit the OQ tag with the original base qualities (with -BQSR)
    inputBinding:
      position: 101
      prefix: --emit_original_quals
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --excludeIntervals
  - id: fix_misencoded_quality_scores
    type:
      - 'null'
      - boolean
    doc: Fix mis-encoded base quality scores
    inputBinding:
      position: 101
      prefix: --fix_misencoded_quality_scores
  - id: gatk_key
    type:
      - 'null'
      - File
    doc: GATK key file required to run with -et NO_ET
    inputBinding:
      position: 101
      prefix: --gatk_key
  - id: global_qscore_prior
    type:
      - 'null'
      - float
    doc: Global Qscore Bayesian prior to use for BQSR
    inputBinding:
      position: 101
      prefix: --globalQScorePrior
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing sequence data (SAM or BAM)
    inputBinding:
      position: 101
      prefix: --input_file
  - id: interval_merging
    type:
      - 'null'
      - string
    doc: Interval merging rule for abutting intervals (ALL|OVERLAPPING_ONLY)
    inputBinding:
      position: 101
      prefix: --interval_merging
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval
    inputBinding:
      position: 101
      prefix: --interval_padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: Set merging approach to use for combining interval inputs 
      (UNION|INTERSECTION)
    inputBinding:
      position: 101
      prefix: --interval_set_rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: keep_program_records
    type:
      - 'null'
      - boolean
    doc: Keep program records in the SAM header
    inputBinding:
      position: 101
      prefix: --keep_program_records
  - id: log_to_file
    type:
      - 'null'
      - File
    doc: Set the logging location
    inputBinding:
      position: 101
      prefix: --log_to_file
  - id: logging_level
    type:
      - 'null'
      - string
    doc: Set the minimum level of logging
    inputBinding:
      position: 101
      prefix: --logging_level
  - id: max_runtime
    type:
      - 'null'
      - int
    doc: Stop execution cleanly as soon as maxRuntime has been reached
    inputBinding:
      position: 101
      prefix: --maxRuntime
  - id: max_runtime_units
    type:
      - 'null'
      - string
    doc: Unit of time used by maxRuntime 
      (NANOSECONDS|MICROSECONDS|MILLISECONDS|SECONDS|MINUTES|HOURS|DAYS)
    inputBinding:
      position: 101
      prefix: --maxRuntimeUnits
  - id: monitor_thread_efficiency
    type:
      - 'null'
      - boolean
    doc: Enable threading efficiency monitoring
    inputBinding:
      position: 101
      prefix: --monitorThreadEfficiency
  - id: non_deterministic_random_seed
    type:
      - 'null'
      - boolean
    doc: Use a non-deterministic random seed
    inputBinding:
      position: 101
      prefix: --nonDeterministicRandomSeed
  - id: num_bam_file_handles
    type:
      - 'null'
      - int
    doc: Total number of BAM file handles to keep open simultaneously
    inputBinding:
      position: 101
      prefix: --num_bam_file_handles
  - id: num_cpu_threads_per_data_thread
    type:
      - 'null'
      - int
    doc: Number of CPU threads to allocate per data thread
    inputBinding:
      position: 101
      prefix: --num_cpu_threads_per_data_thread
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of data threads to allocate to this analysis
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: pedigree
    type:
      - 'null'
      - type: array
        items: File
    doc: Pedigree files for samples
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: pedigree_string
    type:
      - 'null'
      - string
    doc: Pedigree string for samples
    inputBinding:
      position: 101
      prefix: --pedigreeString
  - id: pedigree_validation_type
    type:
      - 'null'
      - string
    doc: Validation strictness for pedigree information (STRICT|SILENT)
    inputBinding:
      position: 101
      prefix: --pedigreeValidationType
  - id: performance_log
    type:
      - 'null'
      - File
    doc: Write GATK runtime performance log to this file
    inputBinding:
      position: 101
      prefix: --performanceLog
  - id: phone_home
    type:
      - 'null'
      - string
    doc: Run reporting mode (NO_ET|AWS|STDOUT)
    inputBinding:
      position: 101
      prefix: --phone_home
  - id: preserve_qscores_less_than
    type:
      - 'null'
      - int
    doc: Don't recalibrate bases with quality scores less than this threshold 
      (with -BQSR)
    inputBinding:
      position: 101
      prefix: --preserve_qscores_less_than
  - id: read_buffer_size
    type:
      - 'null'
      - int
    doc: Number of reads per SAM file to buffer in memory
    inputBinding:
      position: 101
      prefix: --read_buffer_size
  - id: read_filter
    type:
      - 'null'
      - string
    doc: Filters to apply to reads before analysis
    inputBinding:
      position: 101
      prefix: --read_filter
  - id: read_group_black_list
    type:
      - 'null'
      - string
    doc: Exclude read groups based on tags
    inputBinding:
      position: 101
      prefix: --read_group_black_list
  - id: refactor_ndn_cigar_string
    type:
      - 'null'
      - boolean
    doc: refactor cigar string with NDN elements to one element
    inputBinding:
      position: 101
      prefix: --refactor_NDN_cigar_string
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference_sequence
  - id: remove_program_records
    type:
      - 'null'
      - boolean
    doc: Remove program records from the SAM header
    inputBinding:
      position: 101
      prefix: --remove_program_records
  - id: sample_rename_mapping_file
    type:
      - 'null'
      - File
    doc: Rename sample IDs on-the-fly at runtime using the provided mapping file
    inputBinding:
      position: 101
      prefix: --sample_rename_mapping_file
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag to identify this GATK run as part of a group of runs
    inputBinding:
      position: 101
      prefix: --tag
  - id: unsafe
    type:
      - 'null'
      - string
    doc: 'Enable unsafe operations: nothing will be checked at runtime (ALLOW_N_CIGAR_READS|ALLOW_UNINDEXED_BAM|ALLOW_UNSET_BAM_SORT_ORDER|NO_READ_ORDER_VERIFICATION|ALLOW_SEQ_DICT_INCOMPATIBILITY|LENIENT_VCF_PROCESSING|ALL)'
    inputBinding:
      position: 101
      prefix: --unsafe
  - id: use_original_qualities
    type:
      - 'null'
      - boolean
    doc: Use the base quality scores from the OQ tag
    inputBinding:
      position: 101
      prefix: --useOriginalQualities
  - id: validation_strictness
    type:
      - 'null'
      - string
    doc: How strict should we be with validation (STRICT|LENIENT|SILENT)
    inputBinding:
      position: 101
      prefix: --validation_strictness
  - id: variant_index_parameter
    type:
      - 'null'
      - string
    doc: Parameter to pass to the VCF/BCF IndexCreator
    inputBinding:
      position: 101
      prefix: --variant_index_parameter
  - id: variant_index_type
    type:
      - 'null'
      - string
    doc: Type of IndexCreator to use for VCF/BCF indices 
      (DYNAMIC_SEEK|DYNAMIC_SIZE|LINEAR|INTERVAL)
    inputBinding:
      position: 101
      prefix: --variant_index_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-variation:0.2.6--2
stdout: bcbio-variation.out
