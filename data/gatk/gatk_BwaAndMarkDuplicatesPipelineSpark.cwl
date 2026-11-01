cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - BwaAndMarkDuplicatesPipelineSpark
label: gatk_BwaAndMarkDuplicatesPipelineSpark
doc: 'Takes name-sorted file and runs BWA and MarkDuplicates.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least once.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: the output bam
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type: File
    doc: Reference sequence file
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --reference
  - id: bam_partition_size
    type:
      - 'null'
      - long
    doc: 'maximum number of bytes to read from a file into each partition of reads. Setting this higher
      will result in fewer partitions. Note that this will not be equal to the size of the partition in
      memory. Defaults to 0, which uses the default split size (determined by the Hadoop input format,
      typically the size of one HDFS block). Default value: 0.'
    inputBinding:
      position: 101
      prefix: --bam-partition-size
  - id: bwa_mem_index_image
    type:
      - 'null'
      - File
    doc: The BWA-MEM index image file name that you've distributed to each executor
    inputBinding:
      position: 101
      prefix: --bwa-mem-index-image
  - id: create_output_bam_index
    type:
      - 'null'
      - boolean
    doc: 'If true, create a BAM index when writing a coordinate-sorted BAM file. Default value: true.
      Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --create-output-bam-index
      valueFrom: $(String(self))
  - id: create_output_bam_splitting_index
    type:
      - 'null'
      - boolean
    doc: 'If true, create a BAM splitting index (SBI) when writing a coordinate-sorted BAM file. Default
      value: true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --create-output-bam-splitting-index
      valueFrom: $(String(self))
  - id: disable_read_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --disable-read-filter
    doc: 'Read filters to be disabled before analysis This argument may be specified 0 or more times.
      Possible values: {WellformedReadFilter}'
    inputBinding:
      position: 101
  - id: do_not_mark_unmapped_mates
    type:
      - 'null'
      - boolean
    doc: 'Enabling this option will mean unmapped mates of duplicate marked reads will not be marked as
      duplicates. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --do-not-mark-unmapped-mates
      valueFrom: $(String(self))
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Default value: SUM_OF_BASE_QUALITIES.
      Possible values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, FLOW_SUM_OF_BASE_QUALITIES}'
    inputBinding:
      position: 101
      prefix: --duplicate-scoring-strategy
  - id: duplicate_tagging_policy
    type:
      - 'null'
      - string
    doc: 'Determines how duplicate types are recorded in the DT optional attribute. Default value: DontTag.
      Possible values: {DontTag, OpticalOnly, All} Cannot be used in conjunction with argument(s) removeAllDuplicates
      removeSequencingDuplicates'
    inputBinding:
      position: 101
      prefix: --duplicate-tagging-policy
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    doc: One or more genomic intervals to exclude from processing This argument may be specified 0 or
      more times.
    inputBinding:
      position: 101
  - id: exclude_intervals_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --exclude-intervals
    doc: Interval file(s) (.interval_list, .bed or .vcf) passed to --exclude-intervals; use this input
      instead of a path in exclude_intervals so the file is staged.
    inputBinding:
      position: 101
  - id: interval_exclusion_padding
    type:
      - 'null'
      - int
    doc: 'Amount of padding (in bp) to add to each interval you are excluding. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --interval-exclusion-padding
  - id: interval_merging_rule
    type:
      - 'null'
      - string
    doc: 'Interval merging rule for abutting intervals Default value: ALL. Possible values: {ALL, OVERLAPPING_ONLY}'
    inputBinding:
      position: 101
      prefix: --interval-merging-rule
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: 'Amount of padding (in bp) to add to each interval you are including. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: 'Set merging approach to use for combining interval inputs Default value: UNION. Possible values:
      {UNION, INTERSECTION}'
    inputBinding:
      position: 101
      prefix: --interval-set-rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    doc: One or more genomic intervals over which to operate This argument may be specified 0 or more
      times.
    inputBinding:
      position: 101
  - id: intervals_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --intervals
    doc: Interval file(s) (.interval_list, .bed or .vcf) passed to --intervals; use this input instead
      of a path in intervals so the file is staged.
    inputBinding:
      position: 101
  - id: inverted_read_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --inverted-read-filter
    doc: Inverted (with flipped acceptance/failure conditions) read filters applied before analysis (after
      regular read filters). This argument may be specified 0 or more times.
    inputBinding:
      position: 101
  - id: output_cram_version
    type:
      - 'null'
      - string
    doc: 'The CRAM version to write for CRAM output. Spark tools can only write CRAM 3.1; specifying 3.0
      will cause the tool to fail. Default value: 3.1.'
    inputBinding:
      position: 101
      prefix: --output-cram-version
  - id: output_shard_tmp_dir
    type:
      - 'null'
      - string
    doc: when writing a bam, in single sharded mode this directory to write the temporary intermediate
      output shards, if not specified .parts/ will be used Cannot be used in conjunction with argument(s)
      shardedOutput
    inputBinding:
      position: 101
      prefix: --output-shard-tmp-dir
  - id: program_name
    type:
      - 'null'
      - string
    doc: Name of the program running
    inputBinding:
      position: 101
      prefix: --program-name
  - id: read_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --read-filter
    doc: 'Read filters to be applied before analysis This argument may be specified 0 or more times. Possible
      values: {AlignmentAgreesWithHeaderReadFilter, AllowAllReadsReadFilter, AmbiguousBaseReadFilter,
      CigarContainsNoNOperator, ExcessiveEndClippedReadFilter, FirstOfPairReadFilter, FlowBasedTPAttributeSymetricReadFilter,
      FlowBasedTPAttributeValidReadFilter, FragmentLengthReadFilter, GoodCigarReadFilter, HasReadGroupReadFilter,
      HmerQualitySymetricReadFilter, IntervalOverlapReadFilter, JexlExpressionReadTagValueFilter, LibraryReadFilter,
      MappedReadFilter, MappingQualityAvailableReadFilter, MappingQualityNotZeroReadFilter, MappingQualityReadFilter,
      MatchingBasesAndQualsReadFilter, MateDifferentStrandReadFilter, MateDistantReadFilter, MateOnSameContigOrNoMappedMateReadFilter,
      MateUnmappedAndUnmappedReadFilter, MetricsReadFilter, NonChimericOriginalAlignmentReadFilter, NonZeroFragmentLengthReadFilter,
      NonZeroReferenceLengthAlignmentReadFilter, NotDuplicateReadFilter, NotOpticalDuplicateReadFilter,
      NotProperlyPairedReadFilter, NotSecondaryAlignmentReadFilter, NotSupplementaryAlignmentReadFilter,
      OverclippedReadFilter, PairedReadFilter, PassesVendorQualityCheckReadFilter, PlatformReadFilter,
      PlatformUnitReadFilter, PrimaryLineReadFilter, ProperlyPairedReadFilter, ReadGroupBlackListReadFilter,
      ReadGroupHasFlowOrderReadFilter, ReadGroupReadFilter, ReadLengthEqualsCigarLengthReadFilter, ReadLengthReadFilter,
      ReadNameReadFilter, ReadStrandFilter, ReadTagValueFilter, SampleReadFilter, SecondOfPairReadFilter,
      SeqIsStoredReadFilter, SoftClippedReadFilter, ValidAlignmentEndReadFilter, ValidAlignmentStartReadFilter,
      WellformedFlowBasedReadFilter, WellformedReadFilter}'
    inputBinding:
      position: 101
  - id: read_index
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --read-index
    doc: Indices to use for the read inputs. If specified, an index must be provided for every read input
      and in the same order as the read inputs. If this argument is not specified, the path to the index
      for each input will be inferred automatically. This argument may be specified 0 or more times.
    inputBinding:
      position: 101
  - id: read_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM/BAM/CRAM/SRA files read by this program. The default stringency
      value SILENT can improve performance when processing a BAM file in which variable-length data (read,
      qualities, tags) do not otherwise need to be decoded. Default value: SILENT. Possible values: {STRICT,
      LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --read-validation-stringency
  - id: remove_all_duplicates
    type:
      - 'null'
      - boolean
    doc: 'If true do not write duplicates to the output file instead of writing them with appropriate
      flags set. Default value: false. Possible values: {true, false} Cannot be used in conjunction with
      argument(s) taggingPolicy removeSequencingDuplicates'
    inputBinding:
      position: 101
      prefix: --remove-all-duplicates
      valueFrom: $(String(self))
  - id: remove_sequencing_duplicates
    type:
      - 'null'
      - boolean
    doc: 'If true do not write optical/sequencing duplicates to the output file instead of writing them
      with appropriate flags set. Default value: false. Possible values: {true, false} Cannot be used
      in conjunction with argument(s) taggingPolicy removeAllDuplicates'
    inputBinding:
      position: 101
      prefix: --remove-sequencing-duplicates
      valueFrom: $(String(self))
  - id: sharded_output
    type:
      - 'null'
      - boolean
    doc: 'For tools that write an output, write the output in multiple pieces (shards) Default value:
      false. Possible values: {true, false} Cannot be used in conjunction with argument(s) shardedPartsDir'
    inputBinding:
      position: 101
      prefix: --sharded-output
      valueFrom: $(String(self))
  - id: single_end_alignment
    type:
      - 'null'
      - boolean
    doc: 'Run single-end instead of paired-end alignment Default value: false. Possible values: {true,
      false}'
    inputBinding:
      position: 101
      prefix: --single-end-alignment
      valueFrom: $(String(self))
  - id: spark_verbosity
    type:
      - 'null'
      - string
    doc: 'Spark verbosity. Overrides --verbosity for Spark-generated logs only. Possible values: {ALL,
      DEBUG, INFO, WARN, ERROR, FATAL, OFF, TRACE}'
    inputBinding:
      position: 101
      prefix: --spark-verbosity
  - id: splitting_index_granularity
    type:
      - 'null'
      - long
    doc: 'Granularity to use when writing a splitting index, one entry will be put into the index every
      n reads where n is this granularity value. Smaller granularity results in a larger index with more
      available split points. Default value: 4096.'
    inputBinding:
      position: 101
      prefix: --splitting-index-granularity
  - id: use_nio
    type:
      - 'null'
      - boolean
    doc: 'Whether to use NIO or the Hadoop filesystem (default) for reading files. (Note that the Hadoop
      filesystem is always used for writing files.) Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --use-nio
      valueFrom: $(String(self))
  - id: flow_end_pos_uncertainty
    type:
      - 'null'
      - int
    doc: 'Maximal number of bases of reads (fragment) ends difference that is marked as match (should
      only be applied to flow based reads). Default 0. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --flow-end-pos-uncertainty
  - id: flow_q_is_known_end
    type:
      - 'null'
      - boolean
    doc: 'Treat reads (fragment) clipped on tm:Q as known end position (should only be applied to flow
      based reads) (default: false) Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --flow-q-is-known-end
      valueFrom: $(String(self))
  - id: flow_quality_sum_strategy
    type:
      - 'null'
      - boolean
    doc: 'Use specific quality summing strategy for flow based reads. The strategy ensures that the same
      (and correct) quality value is used for all bases of the same homopolymer. Default false. Default
      value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --flow-quality-sum-strategy
      valueFrom: $(String(self))
  - id: flow_skip_start_homopolymers
    type:
      - 'null'
      - int
    doc: 'Skip first N flows, when considering duplicates (should only be applied to flow based reads).
      Default 0. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --flow-skip-start-homopolymers
  - id: flowbased
    type:
      - 'null'
      - boolean
    doc: 'Single argument for enabling the bulk of flow based features (should only be applied to flow
      based reads). Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --flowbased
      valueFrom: $(String(self))
  - id: single_end_reads_clipping_is_end
    type:
      - 'null'
      - boolean
    doc: 'Use clipped, rather than unclipped, when considering duplicates (should only be applied to flow
      based reads). Default false. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --single-end-reads-clipping-is-end
      valueFrom: $(String(self))
  - id: single_end_reads_end_position_significant
    type:
      - 'null'
      - boolean
    doc: 'Make end location of read (fragment) be significant when considering duplicates, in addition
      to the start location, which is always significant (should only be applied to flow based reads).
      Default false. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --single-end-reads-end-position-significant
      valueFrom: $(String(self))
outputs:
  - id: output_out
    type: File
    doc: the output bam
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
      - pattern: .md5
        required: false
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
