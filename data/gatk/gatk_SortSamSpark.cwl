cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SortSamSpark
label: gatk_SortSamSpark
doc: |-
  Sorts the input SAM/BAM/CRAM

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --input
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 101
- id: output
  type: string
  doc: the output file path
  inputBinding:
    position: 101
    prefix: --output
- id: bam_partition_size
  type:
  - 'null'
  - long
  doc: maximum number of bytes to read from a file into each partition of reads. Setting this higher will
    result in fewer partitions. Note that this will not be equal to the size of the partition in memory.
    Defaults to 0, which uses the default split size (determined by the Hadoop input format, typically
    the size of one HDFS block).
  inputBinding:
    position: 101
    prefix: --bam-partition-size
- id: conf
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --conf
  doc: Spark properties to set on the Spark context in the format <property>=<value>
  inputBinding:
    position: 101
- id: create_output_bam_index
  type:
  - 'null'
  - boolean
  doc: If true, create a BAM index when writing a coordinate-sorted BAM file.
  inputBinding:
    position: 101
    prefix: --create-output-bam-index
    valueFrom: '$(self === null ? null : String(self))'
- id: disable_read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --disable-read-filter
  doc: 'Read filters to be disabled before analysis Possible values: {AllowAllReadsReadFilter}'
  inputBinding:
    position: 101
- id: disable_sequence_dictionary_validation
  type:
  - 'null'
  - boolean
  doc: If specified, do not check the sequence dictionaries from our inputs for compatibility. Use at
    your own risk!
  inputBinding:
    position: 101
    prefix: --disable-sequence-dictionary-validation
    valueFrom: '$(self === null ? null : String(self))'
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 101
- id: interval_padding
  type:
  - 'null'
  - int
  doc: Amount of padding (in bp) to add to each interval you are including.
  inputBinding:
    position: 101
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 101
- id: num_reducers
  type:
  - 'null'
  - int
  doc: For tools that shuffle data or write an output, sets the number of reducers. Defaults to 0, which
    gives one partition per 10MB of input.
  inputBinding:
    position: 101
    prefix: --num-reducers
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version to write for CRAM output. Spark tools can only write CRAM 3.1; specifying 3.0
    will cause the tool to fail.
  inputBinding:
    position: 101
    prefix: --output-cram-version
- id: output_shard_tmp_dir
  type:
  - 'null'
  - string
  doc: when writing a bam, in single sharded mode this directory to write the temporary intermediate output
    shards, if not specified .parts/ will be used
  inputBinding:
    position: 101
    prefix: --output-shard-tmp-dir
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-filter
  doc: 'Read filters to be applied before analysis Possible values: {AlignmentAgreesWithHeaderReadFilter,
    AllowAllReadsReadFilter, AmbiguousBaseReadFilter, CigarContainsNoNOperator, ExcessiveEndClippedReadFilter,
    FirstOfPairReadFilter, FlowBasedTPAttributeSymetricReadFilter, FlowBasedTPAttributeValidReadFilter,
    FragmentLengthReadFilter, GoodCigarReadFilter, HasReadGroupReadFilter, HmerQualitySymetricReadFilter,
    IntervalOverlapReadFilter, JexlExpressionReadTagValueFilter, LibraryReadFilter, MappedReadFilter,
    MappingQualityAvailableReadFilter, MappingQualityNotZeroReadFilter, MappingQualityReadFilter, MatchingBasesAndQualsReadFilter,
    MateDifferentStrandReadFilter, MateDistantReadFilter, MateOnSameContigOrNoMappedMateReadFilter, MateUnmappedAndUnmappedReadFilter,
    MetricsReadFilter, NonChimericOriginalAlignmentReadFilter, NonZeroFragmentLengthReadFilter, NonZeroReferenceLengthAlignmentReadFilter,
    NotDuplicateReadFilter, NotOpticalDuplicateReadFilter, NotProperlyPairedReadFilter, NotSecondaryAlignmentReadFilter,
    NotSupplementaryAlignmentReadFilter, OverclippedReadFilter, PairedReadFilter, PassesVendorQualityCheckReadFilter,
    PlatformReadFilter, PlatformUnitReadFilter, PrimaryLineReadFilter, ProperlyPairedReadFilter, ReadGroupBlackListReadFilter,
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
    for each input will be inferred automatically.
  inputBinding:
    position: 101
- id: read_validation_stringency
  type:
  - 'null'
  - string
  doc: 'Validation stringency for all SAM/BAM/CRAM/SRA files read by this program. The default stringency
    value SILENT can improve performance when processing a BAM file in which variable-length data (read,
    qualities, tags) do not otherwise need to be decoded. Possible values: {STRICT, LENIENT, SILENT}'
  inputBinding:
    position: 101
    prefix: --read-validation-stringency
- id: reference
  type:
  - 'null'
  - File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence
  inputBinding:
    position: 101
    prefix: --reference
- id: sharded_output
  type:
  - 'null'
  - boolean
  doc: For tools that write an output, write the output in multiple pieces (shards)
  inputBinding:
    position: 101
    prefix: --sharded-output
    valueFrom: '$(self === null ? null : String(self))'
- id: sort_order
  type:
  - 'null'
  - string
  doc: 'sort order of the output file Possible values: {coordinate, queryname}'
  inputBinding:
    position: 101
    prefix: --sort-order
- id: spark_master
  type:
  - 'null'
  - string
  doc: URL of the Spark Master to submit jobs to when using the Spark pipeline runner.
  inputBinding:
    position: 101
    prefix: --spark-master
- id: spark_verbosity
  type:
  - 'null'
  - string
  doc: 'Spark verbosity. Overrides --verbosity for Spark-generated logs only. Possible values: {ALL, DEBUG,
    INFO, WARN, ERROR, FATAL, OFF, TRACE} Possible values: {ALL, DEBUG, INFO, WARN, ERROR, FATAL, OFF,
    TRACE}'
  inputBinding:
    position: 101
    prefix: --spark-verbosity
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --verbosity
- id: java_options
  type:
  - 'null'
  - string
  doc: Java options for the GATK launcher, for example -Xmx4g
  inputBinding:
    position: 101
    prefix: --java-options
outputs:
- id: output_output
  type: File
  doc: the output file path
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
requirements:
- class: EnvVarRequirement
  envDef:
  - envName: SPARK_LOCAL_IP
    envValue: 127.0.0.1
  - envName: SPARK_LOCAL_HOSTNAME
    envValue: localhost
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
