cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- RevertSamSpark
label: gatk_RevertSamSpark
doc: |-
  This tool removes or restores certain properties of the SAM records, including alignment information, which can be used to produce an unmapped BAM (uBAM) from a previously aligned BAM. It is also capable of restoring the original quality scores of a BAM file that has already undergone base quality score recalibration (BQSR) if theoriginal qualities were retained.

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
  type:
  - 'null'
  - string
  doc: The output SAM/BAM/CRAM file to create, or an output directory if '--output-by-readgroup' is set.
    Cannot be used in conjunction with argument(s) outputMap
  inputBinding:
    position: 101
    prefix: --output
- id: output_map
  type:
  - 'null'
  - File
  doc: Tab separated file with two columns, OUTPUT_MAP_READ_GROUP_FIELD_NAME and OUTPUT_MAP_OUTPUT_FILE_FIELD_NAME,
    providing file mapping only used if '--output-by-readgroup' is set. Cannot be used in conjunction
    with argument(s) output (O)
  inputBinding:
    position: 101
    prefix: --output-map
- id: attributes_to_clear
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --attributes-to-clear
  doc: When removing alignment information, the set of optional tags to remove.
  inputBinding:
    position: 101
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
- id: dont_restore_original_qualities
  type:
  - 'null'
  - boolean
  doc: Set to prevent the tool from setting the OQ field to the QUAL where available.
  inputBinding:
    position: 101
    prefix: --dont-restore-original-qualities
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
- id: keep_alignment_information
  type:
  - 'null'
  - boolean
  doc: Don't remove any of the alignment information from the file.
  inputBinding:
    position: 101
    prefix: --keep-alignment-information
    valueFrom: '$(self === null ? null : String(self))'
- id: keep_first_duplicate
  type:
  - 'null'
  - boolean
  doc: If 'sanitize' only one record when we find more than one record with the same name for R1/R2/unpaired
    reads respectively. For paired end reads, keeps only the first R1 and R2 found respectively, and discards
    all unpaired reads. Duplicates do not refer to the duplicate flag in the FLAG field, but instead reads
    with the same name.
  inputBinding:
    position: 101
    prefix: --keep-first-duplicate
    valueFrom: '$(self === null ? null : String(self))'
- id: library_name
  type:
  - 'null'
  - string
  doc: The library name to use in the reverted output file. This will override the existing sample alias
    in the file and is used only if all the read groups in the input file have the same library name.
  inputBinding:
    position: 101
    prefix: --library-name
- id: num_reducers
  type:
  - 'null'
  - int
  doc: For tools that shuffle data or write an output, sets the number of reducers. Defaults to 0, which
    gives one partition per 10MB of input.
  inputBinding:
    position: 101
    prefix: --num-reducers
- id: output_by_readgroup
  type:
  - 'null'
  - boolean
  doc: When true, outputs each read group in a separate file.
  inputBinding:
    position: 101
    prefix: --output-by-readgroup
    valueFrom: '$(self === null ? null : String(self))'
- id: output_by_readgroup_file_format
  type:
  - 'null'
  - string
  doc: When using --output-by-readgroup, the output file format can be set to a certain format.
  inputBinding:
    position: 101
    prefix: --output-by-readgroup-file-format
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
- id: remove_default_attributes_to_clear
  type:
  - 'null'
  - boolean
  doc: When removing alignment information, the set of optional tags to remove.
  inputBinding:
    position: 101
    prefix: --remove-default-attributes-to-clear
    valueFrom: '$(self === null ? null : String(self))'
- id: remove_duplicate_information
  type:
  - 'null'
  - boolean
  doc: By default we remove duplicate read flags from all reads. Note that if this is true, the output
    may have the unusual but sometimes desirable trait of having unmapped reads that are marked as duplicates.
  inputBinding:
    position: 101
    prefix: --remove-duplicate-information
    valueFrom: '$(self === null ? null : String(self))'
- id: sample_alias
  type:
  - 'null'
  - string
  doc: The sample alias to use in the reverted output file. This will override the existing sample alias
    in the file and is used only if all the read groups in the input file have the same sample alias.
  inputBinding:
    position: 101
    prefix: --sample-alias
- id: sanitize
  type:
  - 'null'
  - boolean
  doc: 'WARNING: This option is potentially destructive. If enabled will discard reads in order to produce
    a consistent output BAM. Reads discarded include (but are not limited to) paired reads with missing
    mates, duplicated records, records with mismatches in length of bases and qualities. This option should
    only be enabled if the output sort order is queryname and will always cause sorting to occur.'
  inputBinding:
    position: 101
    prefix: --sanitize
    valueFrom: '$(self === null ? null : String(self))'
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
  doc: 'The sort order to create the reverted output file with, defaults to whatever is specified in the
    current file Possible values: {unsorted, queryname, coordinate, duplicate, unknown}'
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
  type:
    type: array
    items: File
  doc: Reverted output file, or the files in the output directory when output by read group is set
  outputBinding:
    glob: '$(inputs.output ? (inputs.output_by_readgroup ? inputs.output + "/*" : inputs.output) : [])'
requirements:
- class: EnvVarRequirement
  envDef:
  - envName: SPARK_LOCAL_IP
    envValue: 127.0.0.1
  - envName: SPARK_LOCAL_HOSTNAME
    envValue: localhost
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing: '$([].concat(((inputs.output && inputs.output_by_readgroup) ? [{"entry":{"class":"Directory","listing":[]},"entryname":inputs.output,"writable":true}]
    : [])))'
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
