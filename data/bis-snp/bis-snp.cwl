cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar BisSNP-1.0.1.jar
label: bis-snp
doc: "The BisSNP-1.0.1, Compiled 2018/02/19 05:43:50\nBased on The Genome Analysis
  Toolkit (GATK) v3.8-1-0-gf15c1c3ef (prebuild GATK package could be download here:
  https://github.com/broadgsa/gatk-protected/releases)\nCopyright (c) 2011 USC Epigenome
  Center\nPlease view our documentation at http://epigenome.usc.edu/publicationdata/bissnp2011/\n\
  For support, please send email to lyping1986@gmail.com or benbfly@gmail.com\n\n\
  Tool homepage: http://people.csail.mit.edu/dnaase/bissnp2011/"
inputs:
  - id: allow_potentially_misencoded_quality_scores
    type:
      - 'null'
      - boolean
    doc: "Ignore warnings about base \nquality score encoding"
    inputBinding:
      position: 101
      prefix: --allow_potentially_misencoded_quality_scores
  - id: analysis_type
    type: string
    doc: Type of analysis to run
    inputBinding:
      position: 101
      prefix: --analysis_type
  - id: bam_compression
    type:
      - 'null'
      - int
    doc: "Compression level to use for \nwriting BAM files (0 - 9, \nhigher is more
      compressed)"
    inputBinding:
      position: 101
      prefix: --bam_compression
  - id: baq
    type:
      - 'null'
      - string
    doc: "Type of BAQ calculation to \napply in the engine (OFF|\nCALCULATE_AS_NECESSARY|\n\
      RECALCULATE)"
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
    doc: "Input covariates table file \nfor on-the-fly base quality \nscore recalibration"
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
  - id: disable_auto_index_creation_and_locking_when_reading_rods
    type:
      - 'null'
      - boolean
    doc: "Disable both auto-generation \nof index files and index file \nlocking"
    inputBinding:
      position: 101
      prefix: disable_auto_index_creation_and_locking_when_reading_rods
  - id: disable_bam_indexing
    type:
      - 'null'
      - boolean
    doc: "Turn off on-the-fly creation \nof indices for output BAM/CRAM \nfiles"
    inputBinding:
      position: 101
      prefix: --disable_bam_indexing
  - id: disable_indel_quals
    type:
      - 'null'
      - boolean
    doc: "Disable printing of base \ninsertion and deletion tags \n(with -BQSR)"
    inputBinding:
      position: 101
      prefix: --disable_indel_quals
  - id: disable_read_filter
    type:
      - 'null'
      - string
    doc: Read filters to disable
    inputBinding:
      position: 101
      prefix: --disable_read_filter
  - id: downsample_to_coverage
    type:
      - 'null'
      - int
    doc: "Target coverage threshold for \ndownsampling to coverage"
    inputBinding:
      position: 101
      prefix: --downsample_to_coverage
  - id: downsample_to_fraction
    type:
      - 'null'
      - float
    doc: "Fraction of reads to \ndownsample to"
    inputBinding:
      position: 101
      prefix: --downsample_to_fraction
  - id: downsampling_type
    type:
      - 'null'
      - string
    doc: "Type of read downsampling to \nemploy at a given locus (NONE|\nALL_READS|BY_SAMPLE)"
    inputBinding:
      position: 101
      prefix: --downsampling_type
  - id: emit_original_quals
    type:
      - 'null'
      - boolean
    doc: "Emit the OQ tag with the \noriginal base qualities (with \n-BQSR)"
    inputBinding:
      position: 101
      prefix: --emit_original_quals
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more genomic intervals \nto exclude from processing"
    inputBinding:
      position: 101
      prefix: --excludeIntervals
  - id: fix_misencoded_quality_scores
    type:
      - 'null'
      - boolean
    doc: "Fix mis-encoded base quality \nscores"
    inputBinding:
      position: 101
      prefix: --fix_misencoded_quality_scores
  - id: generate_md5
    type:
      - 'null'
      - boolean
    doc: "Enable on-the-fly creation of \nmd5s for output BAM files."
    inputBinding:
      position: 101
      prefix: --generate_md5
  - id: global_qscore_prior
    type:
      - 'null'
      - float
    doc: "Global Qscore Bayesian prior \nto use for BQSR"
    inputBinding:
      position: 101
      prefix: --globalQScorePrior
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file containing sequence \ndata (BAM or CRAM)"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: interval_merging
    type:
      - 'null'
      - string
    doc: "Interval merging rule for \nabutting intervals (ALL|\nOVERLAPPING_ONLY)"
    inputBinding:
      position: 101
      prefix: --interval_merging
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: "Amount of padding (in bp) to \nadd to each interval"
    inputBinding:
      position: 101
      prefix: --interval_padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: "Set merging approach to use \nfor combining interval inputs \n(UNION|INTERSECTION)"
    inputBinding:
      position: 101
      prefix: --interval_set_rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more genomic intervals \nover which to operate"
    inputBinding:
      position: 101
      prefix: --intervals
  - id: keep_program_records
    type:
      - 'null'
      - boolean
    doc: "Keep program records in the \nSAM header"
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
    doc: "Set the minimum level of \nlogging"
    inputBinding:
      position: 101
      prefix: --logging_level
  - id: max_runtime
    type:
      - 'null'
      - int
    doc: "Stop execution cleanly as soon \nas maxRuntime has been reached"
    inputBinding:
      position: 101
      prefix: --maxRuntime
  - id: max_runtime_units
    type:
      - 'null'
      - string
    doc: "Unit of time used by \nmaxRuntime (NANOSECONDS|\nMICROSECONDS|MILLISECONDS|\n\
      SECONDS|MINUTES|HOURS|DAYS)"
    inputBinding:
      position: 101
      prefix: --maxRuntimeUnits
  - id: monitor_thread_efficiency
    type:
      - 'null'
      - boolean
    doc: "Enable threading efficiency \nmonitoring"
    inputBinding:
      position: 101
      prefix: --monitorThreadEfficiency
  - id: never_trim_vcf_format_field
    type:
      - 'null'
      - boolean
    doc: "Always output all the records \nin VCF FORMAT fields, even if \nsome are
      missing"
    inputBinding:
      position: 101
      prefix: --writeFullFormat
  - id: no_cmdline_in_header
    type:
      - 'null'
      - boolean
    doc: "Don't include the command line \nin output VCF headers"
    inputBinding:
      position: 101
      prefix: --no_cmdline_in_header
  - id: non_deterministic_random_seed
    type:
      - 'null'
      - boolean
    doc: "Use a non-deterministic random \nseed"
    inputBinding:
      position: 101
      prefix: --nonDeterministicRandomSeed
  - id: num_cpu_threads_per_data_thread
    type:
      - 'null'
      - int
    doc: "Number of CPU threads to \nallocate per data thread"
    inputBinding:
      position: 101
      prefix: --num_cpu_threads_per_data_thread
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of data threads to \nallocate to this analysis"
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: pedigree
    type:
      - 'null'
      - File
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
    doc: "Validation strictness for \npedigree (STRICT|SILENT)"
    inputBinding:
      position: 101
      prefix: --pedigreeValidationType
  - id: performance_log
    type:
      - 'null'
      - File
    doc: "Write GATK runtime performance \nlog to this file"
    inputBinding:
      position: 101
      prefix: --performanceLog
  - id: preserve_qscores_less_than
    type:
      - 'null'
      - int
    doc: "Don't recalibrate bases with \nquality scores less than this \nthreshold
      (with -BQSR)"
    inputBinding:
      position: 101
      prefix: --preserve_qscores_less_than
  - id: quantize_quals
    type:
      - 'null'
      - int
    doc: "Quantize quality scores to a \ngiven number of levels (with \n-BQSR)"
    inputBinding:
      position: 101
      prefix: --quantize_quals
  - id: read_buffer_size
    type:
      - 'null'
      - int
    doc: "Number of reads per SAM file \nto buffer in memory"
    inputBinding:
      position: 101
      prefix: --read_buffer_size
  - id: read_filter
    type:
      - 'null'
      - string
    doc: "Filters to apply to reads \nbefore analysis"
    inputBinding:
      position: 101
      prefix: --read_filter
  - id: read_group_black_list
    type:
      - 'null'
      - string
    doc: "Exclude read groups based on \ntags"
    inputBinding:
      position: 101
      prefix: --read_group_black_list
  - id: refactor_ndn_cigar_string
    type:
      - 'null'
      - boolean
    doc: "Reduce NDN elements in CIGAR \nstring"
    inputBinding:
      position: 101
      prefix: --refactor_NDN_cigar_string
  - id: reference_sequence
    type: File
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference_sequence
  - id: reference_window_stop
    type:
      - 'null'
      - int
    doc: Reference window stop
    inputBinding:
      position: 101
      prefix: --reference_window_stop
  - id: remove_program_records
    type:
      - 'null'
      - boolean
    doc: "Remove program records from \nthe SAM header"
    inputBinding:
      position: 101
      prefix: --remove_program_records
  - id: sample_rename_mapping_file
    type:
      - 'null'
      - File
    doc: "Rename sample IDs on-the-fly \nat runtime using the provided \nmapping file"
    inputBinding:
      position: 101
      prefix: --sample_rename_mapping_file
  - id: seconds_between_progress_updates
    type:
      - 'null'
      - int
    doc: "Time interval for process \nmeter information output (in \nseconds)"
    inputBinding:
      position: 101
      prefix: --secondsBetweenProgressUpdates
  - id: show_full_bam_list
    type:
      - 'null'
      - boolean
    doc: "Emit list of input BAM/CRAM \nfiles to log"
    inputBinding:
      position: 101
      prefix: --showFullBamList
  - id: simplifyBAM
    type:
      - 'null'
      - boolean
    doc: "Strip down read content and \ntags"
    inputBinding:
      position: 101
      prefix: --simplifyBAM
  - id: sites_only
    type:
      - 'null'
      - boolean
    doc: Output sites-only VCF
    inputBinding:
      position: 101
      prefix: --sites_only
  - id: static_quantized_quals
    type:
      - 'null'
      - int
    doc: "Use static quantized quality \nscores to a given number of \nlevels (with
      -BQSR)"
    inputBinding:
      position: 101
      prefix: --static_quantized_quals
  - id: unsafe
    type:
      - 'null'
      - string
    doc: "Enable unsafe operations: \nnothing will be checked at \nruntime (ALLOW_N_CIGAR_READS|\n\
      ALLOW_UNINDEXED_BAM|\nALLOW_UNSET_BAM_SORT_ORDER|\nNO_READ_ORDER_VERIFICATION|\n\
      ALLOW_SEQ_DICT_INCOMPATIBILITY|\nLENIENT_VCF_PROCESSING|ALL)"
    inputBinding:
      position: 101
      prefix: --unsafe
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: "Use the JDK Deflater instead \nof the IntelDeflater for \nwriting BAMs"
    inputBinding:
      position: 101
      prefix: --jdk_deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: "Use the JDK Inflater instead \nof the IntelInflater for \nreading BAMs"
    inputBinding:
      position: 101
      prefix: --jdk_inflater
  - id: use_original_qualities
    type:
      - 'null'
      - boolean
    doc: "Use the base quality scores \nfrom the OQ tag"
    inputBinding:
      position: 101
      prefix: --useOriginalQualities
  - id: validation_strictness
    type:
      - 'null'
      - string
    doc: "How strict should we be with \nvalidation (STRICT|LENIENT|\nSILENT)"
    inputBinding:
      position: 101
      prefix: --validation_strictness
  - id: variant_index_parameter
    type:
      - 'null'
      - string
    doc: "Parameter to pass to the \nVCF/BCF IndexCreator"
    inputBinding:
      position: 101
      prefix: --variant_index_parameter
  - id: variant_index_type
    type:
      - 'null'
      - string
    doc: "Type of IndexCreator to use \nfor VCF/BCF indices \n(DYNAMIC_SEEK|DYNAMIC_SIZE|\n\
      LINEAR|INTERVAL)"
    inputBinding:
      position: 101
      prefix: --variant_index_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bis-snp:1.0.1--hdfd78af_3
stdout: bis-snp.out
