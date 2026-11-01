cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - MarkDuplicatesWithMateCigar
label: gatk_MarkDuplicatesWithMateCigar
doc: 'Identifies duplicate reads, accounting for mate CIGAR. This tool locates and tags duplicate reads
  (both PCR and optical) in a BAM, SAM or CRAM file, where duplicate reads are defined as originating
  from the same original fragment of DNA, taking into account the CIGAR string of read mates. It is intended
  as an improvement upon the original MarkDuplicates algorithm, from which it differs in several ways,
  includingdifferences in how it breaks ties. It may be the most effective duplicate marking program available,
  as it handles all cases including clipped and gapped alignments and locates duplicate molecules using
  mate cigar information. However, please note that it is not yet used in the Broad''s production pipeline,
  so use it at your own risk. Note also that this tool will not work with alignments that have large gaps
  or deletions, such as those from RNA-seq data. This is due to the need to buffer small genomic windows
  to ensure integrity of the duplicate marking, while large skips (ex. skipping introns) in the alignment
  records would force making that window very large, thus exhausting memory. Note: Metrics labeled as
  percentages are actually expressed as fractions!


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --INPUT
    doc: One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted. This argument
      must be specified at least once.
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
  - id: metrics_file
    type: string
    doc: File to write duplication metrics to
    inputBinding:
      position: 101
      prefix: --METRICS_FILE
  - id: output
    type: string
    doc: The output file to write marked records to
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: add_pg_tag_to_reads
    type:
      - 'null'
      - boolean
    doc: 'Add PG tag to each read in a SAM or BAM Default value: true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --ADD_PG_TAG_TO_READS
      valueFrom: $(String(self))
  - id: assume_sort_order
    type:
      - 'null'
      - string
    doc: 'If not null, assume that the input file has this order even if the header says otherwise. Possible
      values: {unsorted, queryname, coordinate, duplicate, unknown} Cannot be used in conjunction with
      argument(s) ASSUME_SORTED (AS)'
    inputBinding:
      position: 101
      prefix: --ASSUME_SORT_ORDER
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: 'If true, assume that the input file is coordinate sorted even if the header says otherwise.
      Deprecated, used ASSUME_SORT_ORDER=coordinate instead. Default value: false. Possible values: {true,
      false} Cannot be used in conjunction with argument(s) ASSUME_SORT_ORDER (ASO)'
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
      valueFrom: $(String(self))
  - id: block_size
    type:
      - 'null'
      - int
    doc: 'The block size for use in the coordinate-sorted record buffer. Default value: 100000.'
    inputBinding:
      position: 101
      prefix: --BLOCK_SIZE
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --COMMENT
    doc: Comment(s) to include in the output file's header. This argument may be specified 0 or more times.
    inputBinding:
      position: 101
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
      valueFrom: $(String(self))
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an MD5 digest for any BAM or FASTQ files created. Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
      valueFrom: $(String(self))
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Default value: TOTAL_MAPPED_REFERENCE_LENGTH.
      Possible values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
    inputBinding:
      position: 101
      prefix: --DUPLICATE_SCORING_STRATEGY
  - id: max_optical_duplicate_set_size
    type:
      - 'null'
      - long
    doc: 'This number is the maximum size of a set of duplicate reads for which we will attempt to determine
      which are optical duplicates. Please be aware that if you raise this value too high and do encounter
      a very large set of duplicate reads, it will severely affect the runtime of this tool. To completely
      disable this check, set the value to -1. Default value: 300000.'
    inputBinding:
      position: 101
      prefix: --MAX_OPTICAL_DUPLICATE_SET_SIZE
  - id: minimum_distance
    type:
      - 'null'
      - int
    doc: 'The minimum distance to buffer records to account for clipping on the 5'' end of the records.
      For a given alignment, this parameter controls the width of the window to search for duplicates
      of that alignment. Due to 5'' read clipping, duplicates do not necessarily have the same 5'' alignment
      coordinates, so the algorithm needs to search around the neighborhood. For single end sequencing
      data, the neighborhood is only determined by the amount of clipping (assuming no split reads), thus
      setting MINIMUM_DISTANCE to twice the sequencing read length should be sufficient. For paired end
      sequencing, the neighborhood is also determined by the fragment insert size, so you may want to
      set MINIMUM_DISTANCE to something like twice the 99.5% percentile of the fragment insert size distribution
      (see CollectInsertSizeMetrics). Or you can set this number to -1 to use either a) twice the first
      read''s read length, or b) 100, whichever is smaller. Note that the larger the window, the greater
      the RAM requirements, so you could run into performance limitations if you use a value that is unnecessarily
      large. Default value: -1.'
    inputBinding:
      position: 101
      prefix: --MINIMUM_DISTANCE
  - id: optical_duplicate_pixel_distance
    type:
      - 'null'
      - int
    doc: 'The maximum offset between two duplicate clusters in order to consider them optical duplicates.
      The default is appropriate for unpatterned versions of the Illumina platform. For the patterned
      flowcell models, 2500 is moreappropriate. For other platforms and models, users should experiment
      to find what works best. Default value: 100.'
    inputBinding:
      position: 101
      prefix: --OPTICAL_DUPLICATE_PIXEL_DISTANCE
  - id: program_group_command_line
    type:
      - 'null'
      - string
    doc: Value of CL tag of PG record to be created. If not supplied the command line will be detected
      automatically.
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_COMMAND_LINE
  - id: program_group_name
    type:
      - 'null'
      - string
    doc: 'Value of PN tag of PG record to be created. Default value: MarkDuplicatesWithMateCigar.'
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_NAME
  - id: program_group_version
    type:
      - 'null'
      - string
    doc: Value of VN tag of PG record to be created. If not specified, the version will be detected automatically.
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_VERSION
  - id: program_record_id
    type:
      - 'null'
      - string
    doc: 'The program record ID for the @PG record(s) created by this program. Set to null to disable
      PG record creation. This string may have a suffix appended to avoid collision with other program
      record IDs. Default value: MarkDuplicates.'
    inputBinding:
      position: 101
      prefix: --PROGRAM_RECORD_ID
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: 'MarkDuplicates can use the tile and cluster positions to estimate the rate of optical duplication
      in addition to the dominant source of duplication, PCR, to provide a more accurate estimation of
      library size. By default (with no READ_NAME_REGEX specified), MarkDuplicates will attempt to extract
      coordinates using a split on '':'' (see Note below). Set READ_NAME_REGEX to ''null'' to disable
      optical duplicate detection. Note that without optical duplicate counts, library size estimation
      will be less accurate. If the read name does not follow a standard Illumina colon-separation convention,
      but does contain tile and x,y coordinates, a regular expression can be specified to extract three
      variables: tile/region, x coordinate and y coordinate from a read name. The regular expression must
      contain three capture groups for the three variables, in order. It must match the entire read name.
      e.g. if field names were separated by semi-colon ('';'') this example regex could be specified (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$
      Note that if no READ_NAME_REGEX is specified, the read name is split on '':''. For 5 element names,
      the 3rd, 4th and 5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA
      1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. Default value: <optimized
      capture of last three '':'' separated fields as numeric values>.'
    inputBinding:
      position: 101
      prefix: --READ_NAME_REGEX
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: 'If true do not write duplicates to the output file instead of writing them with appropriate
      flags set. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --REMOVE_DUPLICATES
      valueFrom: $(String(self))
  - id: skip_pairs_with_no_mate_cigar
    type:
      - 'null'
      - boolean
    doc: 'Skip record pairs with no mate cigar and include them in the output. Default value: true. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --SKIP_PAIRS_WITH_NO_MATE_CIGAR
      valueFrom: $(String(self))
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
      improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
      do not otherwise need to be decoded. Default value: STRICT. Possible values: {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
outputs:
  - id: output_out
    type: File
    doc: The output file to write marked records to
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
  - id: metrics_file_out
    type: File
    doc: File to write duplication metrics to
    outputBinding:
      glob: $(inputs.metrics_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
