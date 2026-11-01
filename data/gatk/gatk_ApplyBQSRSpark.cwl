cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - ApplyBQSRSpark
label: gatk_ApplyBQSRSpark
doc: 'Apply a linear base quality recalibration model trained with the BaseRecalibrator tool on Spark.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: bqsr_recal_file
    type: File
    doc: Input covariates table file for base quality score recalibration
    inputBinding:
      position: 101
      prefix: --bqsr-recal-file
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
  - id: allow_missing_read_group
    type:
      - 'null'
      - boolean
    doc: 'Do not throw an error when encountering a read group not in the recal table Default value: false.
      Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --allow-missing-read-group
      valueFrom: $(String(self))
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
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    doc: 'If specified, do not check the sequence dictionaries from our inputs for compatibility. Use
      at your own risk! Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
      valueFrom: $(String(self))
  - id: emit_original_quals
    type:
      - 'null'
      - boolean
    doc: 'Emit original base qualities under the OQ tag Default value: false. Possible values: {true,
      false}'
    inputBinding:
      position: 101
      prefix: --emit-original-quals
      valueFrom: $(String(self))
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
  - id: global_qscore_prior
    type:
      - 'null'
      - double
    doc: 'Global Qscore Bayesian prior to use for BQSR Default value: -1.0.'
    inputBinding:
      position: 101
      prefix: --global-qscore-prior
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
  - id: preserve_qscores_less_than
    type:
      - 'null'
      - int
    doc: 'Don''t recalibrate bases with quality scores less than this threshold Default value: 6.'
    inputBinding:
      position: 101
      prefix: --preserve-qscores-less-than
  - id: program_name
    type:
      - 'null'
      - string
    doc: Name of the program running
    inputBinding:
      position: 101
      prefix: --program-name
  - id: quantize_quals
    type:
      - 'null'
      - int
    doc: 'Quantize quality scores to a given number of levels Default value: 0. Cannot be used in conjunction
      with argument(s) staticQuantizationQuals roundDown'
    inputBinding:
      position: 101
      prefix: --quantize-quals
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
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: use_original_qualities
    type:
      - 'null'
      - boolean
    doc: 'Use the base quality scores from the OQ tag Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --use-original-qualities
      valueFrom: $(String(self))
  - id: round_down_quantized
    type:
      - 'null'
      - boolean
    doc: 'Round quals down to nearest quantized qual Default value: false. Possible values: {true, false}
      Cannot be used in conjunction with argument(s) quantizationLevels'
    inputBinding:
      position: 101
      prefix: --round-down-quantized
      valueFrom: $(String(self))
  - id: static_quantized_quals
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --static-quantized-quals
    doc: Use static quantized quality scores to a given number of levels (with -bqsr) This argument may
      be specified 0 or more times. Cannot be used in conjunction with argument(s) quantizationLevels
    inputBinding:
      position: 101
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
