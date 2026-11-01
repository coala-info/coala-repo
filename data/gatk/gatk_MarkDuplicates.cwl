cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - MarkDuplicates
label: gatk_MarkDuplicates
doc: 'Identifies duplicate reads. This tool locates and tags duplicate reads in a SAM, BAM or CRAM file,
  where duplicate reads are defined as originating from a single fragment of DNA. Duplicates can arise
  during sample preparation e.g. library construction using PCR. See also EstimateLibraryComplexity for
  additional notes on PCR duplication artifacts. Duplicate reads can also result from a single amplification
  cluster, incorrectly detected as multiple clusters by the optical sensor of the sequencing instrument.
  These duplication artifacts are referred to as optical duplicates. The MarkDuplicates tool works by
  comparing sequences in the 5 prime positions of both reads and read-pairs in a SAM/BAM file. A BARCODE_TAG
  option is available to facilitate duplicate marking using molecular barcodes. After duplicate reads
  are collected, the tool differentiates the primary and duplicate reads using an algorithm that ranks
  reads by the sums of their base-quality scores (default method). Note that this is different from directly
  checking if the sequences match, which MarkDuplicates does not do. The tool''s main output is a new
  SAM, BAM or CRAM file, in which duplicates have been identified in the SAM flags field for each read.
  Duplicates are marked with the hexadecimal value of 0x0400, which corresponds to a decimal value of
  1024. If you are not familiar with this type of annotation, please see the following blog post for additional
  information. Although the bitwise flag annotation indicates whether a read was marked as a duplicate,
  it does not identify the type of duplicate. To do this, a new tag called the duplicate type (DT) tag
  was recently added as an optional output in the ''optional field'' section of a SAM/BAM/CRAM file. Invoking
  the TAGGING_POLICY option, you can instruct the program to mark all the duplicates (All), only the optical
  duplicates (OpticalOnly), or no duplicates (DontTag). The records within the output of a SAM/BAM/CRAM
  file will have values for the ''DT'' tag (depending on the invoked TAGGING_POLICY), as either library/PCR-generated
  duplicates (LB), or sequencing-platform artifact duplicates (SQ). This tool uses the READ_NAME_REGEX
  and the OPTICAL_DUPLICATE_PIXEL_DISTANCE options as the primary methods to identify and differentiate
  duplicate types. Set READ_NAME_REGEX to null to skip optical duplicate detection, e.g. for RNA-seq or
  other data where duplicate sets are extremely large and estimating library complexity is not an aim.
  Note that without optical duplicate counts, library size estimation will be inaccurate. MarkDuplicates
  also produces a metrics file indicating the numbers of duplicates for both single- and paired-end reads.
  The program can take either coordinate-sorted or query-sorted inputs, however the behavior is slightly
  different. When the input is coordinate-sorted, unmapped mates of mapped records and supplementary/secondary
  alignments are not marked as duplicates. However, when the input is query-sorted (actually query-grouped),
  then unmapped mates and secondary/supplementary reads are not excluded from the duplication test and
  can be marked as duplicate reads. If desired, duplicates can be removed using the REMOVE_DUPLICATE and
  REMOVE_SEQUENCING_DUPLICATES options.


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
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Barcode SAM tag (ex. BC for 10X Genomics)
    inputBinding:
      position: 101
      prefix: --BARCODE_TAG
  - id: clear_dt
    type:
      - 'null'
      - boolean
    doc: 'Clear DT tag from input SAM records. Should be set to false if input SAM doesn''t have this
      tag. Default true Default value: true. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CLEAR_DT
      valueFrom: $(String(self))
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
  - id: duplex_umi
    type:
      - 'null'
      - boolean
    doc: 'Treat UMIs as being duplex stranded. This option requires that the UMI consist of two equal
      length strings that are separated by a hyphen (e.g. ''ATC-GTC''). Reads are considered duplicates
      if, in addition to standard definition, have identical normalized UMIs. A UMI from the ''bottom''
      strand is normalized by swapping its content around the hyphen (eg. ATC-GTC becomes GTC-ATC). A
      UMI from the ''top'' strand is already normalized as it is. Both reads from a read pair considered
      top strand if the read 1 unclipped 5'' coordinate is less than the read 2 unclipped 5'' coordinate.
      All chimeric reads and read fragments are treated as having come from the top strand. With this
      option is it required that the BARCODE_TAG hold non-normalized UMIs. Default false. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --DUPLEX_UMI
      valueFrom: $(String(self))
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Default value: SUM_OF_BASE_QUALITIES.
      Possible values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
    inputBinding:
      position: 101
      prefix: --DUPLICATE_SCORING_STRATEGY
  - id: flow_dup_strategy
    type:
      - 'null'
      - string
    doc: 'Use specific quality summing strategy for flow based reads. Two strategies are available: FLOW_QUALITY_SUM_STRATEG:
      The selects the read with the best total homopolymer quality. FLOW_END_QUALITY_STRATEGY: The strategy
      selects the read with the best homopolymer quality close to the end (10 bases) of the read. The
      latter strategy is recommended for samples with high duplication rate Default value: FLOW_QUALITY_SUM_STRATEGY.
      Possible values: {FLOW_QUALITY_SUM_STRATEGY, FLOW_END_QUALITY_STRATEGY}'
    inputBinding:
      position: 101
      prefix: --FLOW_DUP_STRATEGY
  - id: flow_effective_quality_threshold
    type:
      - 'null'
      - int
    doc: 'Threshold for considering a quality value high enough to be included when calculating FLOW_QUALITY_SUM_STRATEGY
      calculation. Default value: 15.'
    inputBinding:
      position: 101
      prefix: --FLOW_EFFECTIVE_QUALITY_THRESHOLD
  - id: flow_mode
    type:
      - 'null'
      - boolean
    doc: 'enable parameters and behavior specific to flow based reads. Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --FLOW_MODE
      valueFrom: $(String(self))
  - id: flow_q_is_known_end
    type:
      - 'null'
      - boolean
    doc: 'Treat position of read trimming based on quality as the known end (relevant for flow based reads).
      Default false - if the read is trimmed on quality its end is not defined and the read is duplicate
      of any read starting at the same place. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --FLOW_Q_IS_KNOWN_END
      valueFrom: $(String(self))
  - id: flow_skip_first_n_flows
    type:
      - 'null'
      - int
    doc: 'Skip first N flows, starting from the read''s start, when considering duplicates. Useful for
      flow based reads where sometimes there is noise in the first flows (for this argument, "read start"
      means 5'' end). Default value: 0.'
    inputBinding:
      position: 101
      prefix: --FLOW_SKIP_FIRST_N_FLOWS
  - id: flow_unpaired_end_uncertainty
    type:
      - 'null'
      - int
    doc: 'Maximal difference of the read end position that counted as equal. Useful for flow based reads
      where the end position might vary due to sequencing errors. (for this argument, "read end" means
      3'' end) Default value: 0.'
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_END_UNCERTAINTY
  - id: flow_unpaired_start_uncertainty
    type:
      - 'null'
      - int
    doc: 'Maximal difference of the read start position that counted as equal. Useful for flow based reads
      where the end position might vary due to sequencing errors. (for this argument, "read start" means
      5'' end in the direction of sequencing) Default value: 0.'
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_START_UNCERTAINTY
  - id: flow_use_end_in_unpaired_reads
    type:
      - 'null'
      - boolean
    doc: 'Make the end location of single end read be significant when considering duplicates, in addition
      to the start location, which is always significant (i.e. require single-ended reads to start andend
      on the same position to be considered duplicate) (for this argument, "read end" means 3'' end).
      Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --FLOW_USE_END_IN_UNPAIRED_READS
      valueFrom: $(String(self))
  - id: flow_use_unpaired_clipped_end
    type:
      - 'null'
      - boolean
    doc: 'Use position of the clipping as the end position, when considering duplicates (or use the unclipped
      end position) (for this argument, "read end" means 3'' end). Default value: false. Possible values:
      {true, false}'
    inputBinding:
      position: 101
      prefix: --FLOW_USE_UNPAIRED_CLIPPED_END
      valueFrom: $(String(self))
  - id: max_file_handles_for_read_ends_map
    type:
      - 'null'
      - int
    doc: 'Maximum number of file handles to keep open when spilling read ends to disk. Set this number
      a little lower than the per-process maximum number of file that may be open. This number can be
      found by executing the ''ulimit -n'' command on a Unix system. Default value: 8000.'
    inputBinding:
      position: 101
      prefix: --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP
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
  - id: max_sequences_for_disk_read_ends_map
    type:
      - 'null'
      - int
    doc: 'This option is obsolete. ReadEnds will always be spilled to disk. Default value: 50000.'
    inputBinding:
      position: 101
      prefix: --MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP
  - id: molecular_identifier_tag
    type:
      - 'null'
      - string
    doc: SAM tag to uniquely identify the molecule from which a read was derived. Use of this option requires
      that the BARCODE_TAG option be set to a non null value. Default null.
    inputBinding:
      position: 101
      prefix: --MOLECULAR_IDENTIFIER_TAG
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
    doc: 'Value of PN tag of PG record to be created. Default value: MarkDuplicates.'
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
  - id: read_one_barcode_tag
    type:
      - 'null'
      - string
    doc: Read one barcode SAM tag (ex. BX for 10X Genomics)
    inputBinding:
      position: 101
      prefix: --READ_ONE_BARCODE_TAG
  - id: read_two_barcode_tag
    type:
      - 'null'
      - string
    doc: Read two barcode SAM tag (ex. BX for 10X Genomics)
    inputBinding:
      position: 101
      prefix: --READ_TWO_BARCODE_TAG
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
  - id: remove_sequencing_duplicates
    type:
      - 'null'
      - boolean
    doc: 'If true remove ''optical'' duplicates and other duplicates that appear to have arisen from the
      sequencing process instead of the library preparation process, even if REMOVE_DUPLICATES is false.
      If REMOVE_DUPLICATES is true, all duplicates are removed and this option is ignored. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --REMOVE_SEQUENCING_DUPLICATES
      valueFrom: $(String(self))
  - id: sorting_collection_size_ratio
    type:
      - 'null'
      - double
    doc: 'This number, plus the maximum RAM available to the JVM, determine the memory footprint used
      by some of the sorting collections. If you are running out of memory, try reducing this number.
      Default value: 0.25.'
    inputBinding:
      position: 101
      prefix: --SORTING_COLLECTION_SIZE_RATIO
  - id: tag_duplicate_set_members
    type:
      - 'null'
      - boolean
    doc: 'If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG (DS),
      indicates the size of the duplicate set. The smallest possible DS value is 2 which occurs when two
      reads map to the same portion of the reference only one of which is marked as duplicate. The second
      tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier for the duplicate set to which
      the record belongs. This identifier is the index-in-file of the representative read that was selected
      out of the duplicate set. Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --TAG_DUPLICATE_SET_MEMBERS
      valueFrom: $(String(self))
  - id: tagging_policy
    type:
      - 'null'
      - string
    doc: 'Determines how duplicate types are recorded in the DT optional attribute. Default value: DontTag.
      Possible values: {DontTag, OpticalOnly, All}'
    inputBinding:
      position: 101
      prefix: --TAGGING_POLICY
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
