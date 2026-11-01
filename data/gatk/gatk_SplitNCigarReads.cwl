cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SplitNCigarReads
label: gatk_SplitNCigarReads
doc: |-
  Splits reads that contain Ns in their cigar string (e.g. spanning splicing events).

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
  doc: Write output to this BAM filename
  inputBinding:
    position: 101
    prefix: --output
- id: reference
  type: File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file
  inputBinding:
    position: 101
    prefix: --reference
- id: add_output_sam_program_record
  type:
  - 'null'
  - boolean
  doc: If true, adds a PG tag to created SAM/BAM/CRAM files.
  inputBinding:
    position: 101
    prefix: --add-output-sam-program-record
    valueFrom: '$(self === null ? null : String(self))'
- id: create_output_bam_index
  type:
  - 'null'
  - boolean
  doc: If true, create a BAM/CRAM index when writing a coordinate-sorted BAM/CRAM file.
  inputBinding:
    position: 101
    prefix: --create-output-bam-index
    valueFrom: '$(self === null ? null : String(self))'
- id: create_output_bam_md5
  type:
  - 'null'
  - boolean
  doc: If true, create a MD5 digest for any BAM/SAM/CRAM file created
  inputBinding:
    position: 101
    prefix: --create-output-bam-md5
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
- id: do_not_fix_overhangs
  type:
  - 'null'
  - boolean
  doc: do not have the walker soft-clip overhanging sections of the reads
  inputBinding:
    position: 101
    prefix: --do-not-fix-overhangs
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
- id: max_bases_in_overhang
  type:
  - 'null'
  - int
  doc: max number of bases allowed in the overhang
  inputBinding:
    position: 101
    prefix: --max-bases-in-overhang
- id: max_mismatches_in_overhang
  type:
  - 'null'
  - int
  doc: max number of mismatches allowed in the overhang
  inputBinding:
    position: 101
    prefix: --max-mismatches-in-overhang
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version ('3.0' or '3.1') to write for CRAM output. Ignored for BAM/SAM output. Note that
    CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0.
  inputBinding:
    position: 101
    prefix: --output-cram-version
- id: process_secondary_alignments
  type:
  - 'null'
  - boolean
  doc: have the walker split secondary alignments (will still repair MC tag without it)
  inputBinding:
    position: 101
    prefix: --process-secondary-alignments
    valueFrom: '$(self === null ? null : String(self))'
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
- id: refactor_cigar_string
  type:
  - 'null'
  - boolean
  doc: refactor cigar string with NDN elements to one element
  inputBinding:
    position: 101
    prefix: --refactor-cigar-string
    valueFrom: '$(self === null ? null : String(self))'
- id: skip_mapping_quality_transform
  type:
  - 'null'
  - boolean
  doc: skip the 255 -> 60 MQ read transform
  inputBinding:
    position: 101
    prefix: --skip-mapping-quality-transform
    valueFrom: '$(self === null ? null : String(self))'
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --verbosity
- id: max_reads_in_memory
  type:
  - 'null'
  - int
  doc: max reads allowed to be kept in memory at a time by the BAM writer
  inputBinding:
    position: 101
    prefix: --max-reads-in-memory
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
  doc: Write output to this BAM filename
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
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
