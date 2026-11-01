cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - ClipReads
label: gatk_ClipReads
doc: 'Read clipping based on quality, position or sequence matching. This tool provides simple, powerful
  read clipping capabilities that allow you to remove low quality strings of bases, sections of reads,
  and reads containing user-provided sequences.


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
    doc: BAM output file
    inputBinding:
      position: 101
      prefix: --output
  - id: add_output_sam_program_record
    type:
      - 'null'
      - boolean
    doc: 'If true, adds a PG tag to created SAM/BAM/CRAM files. Default value: true. Possible values:
      {true, false}'
    inputBinding:
      position: 101
      prefix: --add-output-sam-program-record
      valueFrom: $(String(self))
  - id: clip_adapter
    type:
      - 'null'
      - boolean
    doc: 'Clip locations according to XF, XT tags. This will destroy reads which have none of these tags
      Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --clip-adapter
      valueFrom: $(String(self))
  - id: clip_representation
    type:
      - 'null'
      - string
    doc: 'How should we actually clip the bases? Default value: WRITE_NS. Possible values: {WRITE_NS,
      WRITE_Q0S, WRITE_NS_Q0S, SOFTCLIP_BASES, HARDCLIP_BASES, REVERT_SOFTCLIPPED_BASES}'
    inputBinding:
      position: 101
      prefix: --clip-representation
  - id: clip_sequence
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --clip-sequence
    doc: Remove sequences within reads matching this sequence This argument may be specified 0 or more
      times.
    inputBinding:
      position: 101
  - id: clip_sequences_file
    type:
      - 'null'
      - File
    doc: Remove sequences within reads matching the sequences in this FASTA file
    inputBinding:
      position: 101
      prefix: --clip-sequences-file
  - id: create_output_bam_index
    type:
      - 'null'
      - boolean
    doc: 'If true, create a BAM/CRAM index when writing a coordinate-sorted BAM/CRAM file. Default value:
      true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --create-output-bam-index
      valueFrom: $(String(self))
  - id: create_output_bam_md5
    type:
      - 'null'
      - boolean
    doc: 'If true, create a MD5 digest for any BAM/SAM/CRAM file created Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --create-output-bam-md5
      valueFrom: $(String(self))
  - id: cycles_to_trim
    type:
      - 'null'
      - string
    doc: String indicating machine cycles to clip from the reads
    inputBinding:
      position: 101
      prefix: --cycles-to-trim
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
  - id: min_read_length_to_output
    type:
      - 'null'
      - int
    doc: 'Shortest read to output. Note that this works correctly only on non-paired reads. Default value:
      0.'
    inputBinding:
      position: 101
      prefix: --min-read-length-to-output
  - id: output_cram_version
    type:
      - 'null'
      - string
    doc: 'The CRAM version (''3.0'' or ''3.1'') to write for CRAM output. Ignored for BAM/SAM output.
      Note that CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0. Default value:
      3.1.'
    inputBinding:
      position: 101
      prefix: --output-cram-version
  - id: output_statistics
    type:
      - 'null'
      - string
    doc: File to output statistics
    inputBinding:
      position: 101
      prefix: --output-statistics
  - id: q_trimming_threshold
    type:
      - 'null'
      - int
    doc: 'If provided, the Q-score clipper will be applied Default value: -1.'
    inputBinding:
      position: 101
      prefix: --q-trimming-threshold
  - id: read
    type:
      - 'null'
      - string
    doc: ''
    inputBinding:
      position: 101
      prefix: --read
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
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary. Must be a .dict
      file.
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
outputs:
  - id: output_out
    type: File
    doc: BAM output file
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
  - id: output_statistics_out
    type:
      - 'null'
      - File
    doc: 'File to output statistics Default value: null.'
    outputBinding:
      glob: $(inputs.output_statistics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
