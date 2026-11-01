cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- UmiAwareMarkDuplicatesWithMateCigar
label: gatk_UmiAwareMarkDuplicatesWithMateCigar
doc: |-
  Identifies duplicate reads using information from read positions and UMIs. This tool locates and tags duplicate reads in a BAM or SAM file, where duplicate reads aredefined as originating from a single fragment of DNA. It is based on the {@link MarkDuplicatesWithMateCigar} tool, with added logicto leverage Unique Molecular Identifier (UMI) information. It makes use of the fact that duplicate sets with UMIs can be broken up into subsets based oninformation contained in the UMI. In addition to assuming that all members of a duplicate set must have the same start and end position, it imposes thatthey must also have sufficiently similar UMIs. In this context, 'sufficiently similar' is parameterized by the command lineargument MAX_EDIT_DISTANCE_TO_JOIN, which sets the edit distance between UMIs that will be considered to be part of the sameoriginal molecule. This logic allows for sequencing errors in UMIs. If UMIs contain dashes, the dashes will be ignored. If UMIs contain Ns, these UMIs will not contribute to UMI metricsassociated with each record. If the MAX_EDIT_DISTANCE_TO_JOIN allows, UMIs with Ns will be included in the duplicate set andthe UMI metrics associated with each duplicate set. Ns are counted as an edit distance from other bases {ATCG}, but are notconsidered different from each other. This tool is NOT intended to be used on data without UMIs; for marking duplicates in non-UMI data, see {@link MarkDuplicates} or{@link MarkDuplicatesWithMateCigar}. Mixed data (where some reads have UMIs and others do not) is not supported. Note also that this tool will not work with alignments that have large gaps or deletions, such as those from RNA-seq data.This is due to the need to buffer small genomic windows to ensure integrity of the duplicate marking, while large skips(ex. skipping introns) in the alignment records would force making that window very large, thus exhausting memory. Note: Metrics labeled as percentages are actually expressed as fractions!

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted.
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
- id: umi_metrics_file
  type: string
  doc: UMI Metrics
  inputBinding:
    position: 101
    prefix: --UMI_METRICS_FILE
- id: add_pg_tag_to_reads
  type:
  - 'null'
  - boolean
  doc: Add PG tag to each read in a SAM or BAM
  inputBinding:
    position: 101
    prefix: --ADD_PG_TAG_TO_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: allow_missing_umis
  type:
  - 'null'
  - boolean
  doc: 'FOR TESTING ONLY: allow for missing UMIs if data doesn''t have UMIs. This option is intended to
    be used ONLY for testing the code. Use MarkDuplicatesWithMateCigar if data has no UMIs. Mixed data
    (where some reads have UMIs and others do not) is not supported.'
  inputBinding:
    position: 101
    prefix: --ALLOW_MISSING_UMIS
    valueFrom: '$(self === null ? null : String(self))'
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 101
- id: assume_sort_order
  type:
  - 'null'
  - string
  doc: 'If not null, assume that the input file has this order even if the header says otherwise. Possible
    values: {unsorted, queryname, coordinate, duplicate, unknown}'
  inputBinding:
    position: 101
    prefix: --ASSUME_SORT_ORDER
- id: assume_sorted
  type:
  - 'null'
  - boolean
  doc: If true, assume that the input file is coordinate sorted even if the header says otherwise. Deprecated,
    used ASSUME_SORT_ORDER=coordinate instead.
  inputBinding:
    position: 101
    prefix: --ASSUME_SORTED
    valueFrom: '$(self === null ? null : String(self))'
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
  doc: Clear DT tag from input SAM records. Should be set to false if input SAM doesn't have this tag.
    Default true
  inputBinding:
    position: 101
    prefix: --CLEAR_DT
    valueFrom: '$(self === null ? null : String(self))'
- id: comment
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --COMMENT
  doc: Comment(s) to include in the output file's header.
  inputBinding:
    position: 101
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level for all compressed files created (e.g. BAM and VCF).
  inputBinding:
    position: 101
    prefix: --COMPRESSION_LEVEL
- id: create_index
  type:
  - 'null'
  - boolean
  doc: Whether to create an index when writing VCF or coordinate sorted BAM output.
  inputBinding:
    position: 101
    prefix: --CREATE_INDEX
    valueFrom: '$(self === null ? null : String(self))'
- id: create_md5_file
  type:
  - 'null'
  - boolean
  doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
  inputBinding:
    position: 101
    prefix: --CREATE_MD5_FILE
    valueFrom: '$(self === null ? null : String(self))'
- id: duplex_umi
  type:
  - 'null'
  - boolean
  doc: Treat UMIs as being duplex stranded. This option requires that the UMI consist of two equal length
    strings that are separated by a hyphen (e.g. 'ATC-GTC'). Reads are considered duplicates if, in addition
    to standard definition, have identical normalized UMIs. A UMI from the 'bottom' strand is normalized
    by swapping its content around the hyphen (eg. ATC-GTC becomes GTC-ATC). A UMI from the 'top' strand
    is already normalized as it is. Both reads from a read pair considered top strand if the read 1 unclipped
    5' coordinate is less than the read 2 unclipped 5' coordinate. All chimeric reads and read fragments
    are treated as having come from the top strand. With this option is it required that the BARCODE_TAG
    hold non-normalized UMIs. Default false.
  inputBinding:
    position: 101
    prefix: --DUPLEX_UMI
    valueFrom: '$(self === null ? null : String(self))'
- id: duplicate_scoring_strategy
  type:
  - 'null'
  - string
  doc: 'The scoring strategy for choosing the non-duplicate among candidates. Possible values: {SUM_OF_BASE_QUALITIES,
    TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
  inputBinding:
    position: 101
    prefix: --DUPLICATE_SCORING_STRATEGY
- id: flow_dup_strategy
  type:
  - 'null'
  - string
  doc: 'Use specific quality summing strategy for flow based reads. Two strategies are available: FLOW_QUALITY_SUM_STRATEG:
    The selects the read with the best total homopolymer quality. FLOW_END_QUALITY_STRATEGY: The strategy
    selects the read with the best homopolymer quality close to the end (10 bases) of the read. The latter
    strategy is recommended for samples with high duplication rate Possible values: {FLOW_QUALITY_SUM_STRATEGY,
    FLOW_END_QUALITY_STRATEGY}'
  inputBinding:
    position: 101
    prefix: --FLOW_DUP_STRATEGY
- id: flow_effective_quality_threshold
  type:
  - 'null'
  - int
  doc: Threshold for considering a quality value high enough to be included when calculating FLOW_QUALITY_SUM_STRATEGY
    calculation.
  inputBinding:
    position: 101
    prefix: --FLOW_EFFECTIVE_QUALITY_THRESHOLD
- id: flow_mode
  type:
  - 'null'
  - boolean
  doc: enable parameters and behavior specific to flow based reads.
  inputBinding:
    position: 101
    prefix: --FLOW_MODE
    valueFrom: '$(self === null ? null : String(self))'
- id: flow_q_is_known_end
  type:
  - 'null'
  - boolean
  doc: Treat position of read trimming based on quality as the known end (relevant for flow based reads).
    Default false - if the read is trimmed on quality its end is not defined and the read is duplicate
    of any read starting at the same place.
  inputBinding:
    position: 101
    prefix: --FLOW_Q_IS_KNOWN_END
    valueFrom: '$(self === null ? null : String(self))'
- id: flow_skip_first_n_flows
  type:
  - 'null'
  - int
  doc: Skip first N flows, starting from the read's start, when considering duplicates. Useful for flow
    based reads where sometimes there is noise in the first flows (for this argument, "read start" means
    5' end).
  inputBinding:
    position: 101
    prefix: --FLOW_SKIP_FIRST_N_FLOWS
- id: flow_unpaired_end_uncertainty
  type:
  - 'null'
  - int
  doc: Maximal difference of the read end position that counted as equal. Useful for flow based reads
    where the end position might vary due to sequencing errors. (for this argument, "read end" means 3'
    end)
  inputBinding:
    position: 101
    prefix: --FLOW_UNPAIRED_END_UNCERTAINTY
- id: flow_unpaired_start_uncertainty
  type:
  - 'null'
  - int
  doc: Maximal difference of the read start position that counted as equal. Useful for flow based reads
    where the end position might vary due to sequencing errors. (for this argument, "read start" means
    5' end in the direction of sequencing)
  inputBinding:
    position: 101
    prefix: --FLOW_UNPAIRED_START_UNCERTAINTY
- id: flow_use_end_in_unpaired_reads
  type:
  - 'null'
  - boolean
  doc: Make the end location of single end read be significant when considering duplicates, in addition
    to the start location, which is always significant (i.e. require single-ended reads to start andend
    on the same position to be considered duplicate) (for this argument, "read end" means 3' end).
  inputBinding:
    position: 101
    prefix: --FLOW_USE_END_IN_UNPAIRED_READS
    valueFrom: '$(self === null ? null : String(self))'
- id: flow_use_unpaired_clipped_end
  type:
  - 'null'
  - boolean
  doc: Use position of the clipping as the end position, when considering duplicates (or use the unclipped
    end position) (for this argument, "read end" means 3' end).
  inputBinding:
    position: 101
    prefix: --FLOW_USE_UNPAIRED_CLIPPED_END
    valueFrom: '$(self === null ? null : String(self))'
- id: max_edit_distance_to_join
  type:
  - 'null'
  - int
  doc: Largest edit distance that UMIs must have in order to be considered as coming from distinct source
    molecules.
  inputBinding:
    position: 101
    prefix: --MAX_EDIT_DISTANCE_TO_JOIN
- id: max_file_handles_for_read_ends_map
  type:
  - 'null'
  - int
  doc: Maximum number of file handles to keep open when spilling read ends to disk. Set this number a
    little lower than the per-process maximum number of file that may be open. This number can be found
    by executing the 'ulimit -n' command on a Unix system.
  inputBinding:
    position: 101
    prefix: --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP
- id: max_optical_duplicate_set_size
  type:
  - 'null'
  - long
  doc: This number is the maximum size of a set of duplicate reads for which we will attempt to determine
    which are optical duplicates. Please be aware that if you raise this value too high and do encounter
    a very large set of duplicate reads, it will severely affect the runtime of this tool. To completely
    disable this check, set the value to -1.
  inputBinding:
    position: 101
    prefix: --MAX_OPTICAL_DUPLICATE_SET_SIZE
- id: max_records_in_ram
  type:
  - 'null'
  - int
  doc: When writing files that need to be sorted, this will specify the number of records stored in RAM
    before spilling to disk. Increasing this number reduces the number of file handles needed to sort
    the file, and increases the amount of RAM needed.
  inputBinding:
    position: 101
    prefix: --MAX_RECORDS_IN_RAM
- id: max_sequences_for_disk_read_ends_map
  type:
  - 'null'
  - int
  doc: This option is obsolete. ReadEnds will always be spilled to disk.
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
  doc: The maximum offset between two duplicate clusters in order to consider them optical duplicates.
    The default is appropriate for unpatterned versions of the Illumina platform. For the patterned flowcell
    models, 2500 is moreappropriate. For other platforms and models, users should experiment to find what
    works best.
  inputBinding:
    position: 101
    prefix: --OPTICAL_DUPLICATE_PIXEL_DISTANCE
- id: program_group_command_line
  type:
  - 'null'
  - string
  doc: Value of CL tag of PG record to be created. If not supplied the command line will be detected automatically.
  inputBinding:
    position: 101
    prefix: --PROGRAM_GROUP_COMMAND_LINE
- id: program_group_name
  type:
  - 'null'
  - string
  doc: Value of PN tag of PG record to be created.
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
  doc: The program record ID for the @PG record(s) created by this program. Set to null to disable PG
    record creation. This string may have a suffix appended to avoid collision with other program record
    IDs.
  inputBinding:
    position: 101
    prefix: --PROGRAM_RECORD_ID
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: read_name_regex
  type:
  - 'null'
  - string
  doc: 'MarkDuplicates can use the tile and cluster positions to estimate the rate of optical duplication
    in addition to the dominant source of duplication, PCR, to provide a more accurate estimation of library
    size. By default (with no READ_NAME_REGEX specified), MarkDuplicates will attempt to extract coordinates
    using a split on '':'' (see Note below). Set READ_NAME_REGEX to ''null'' to disable optical duplicate
    detection. Note that without optical duplicate counts, library size estimation will be less accurate.
    If the read name does not follow a standard Illumina colon-separation convention, but does contain
    tile and x,y coordinates, a regular expression can be specified to extract three variables: tile/region,
    x coordinate and y coordinate from a read name. The regular expression must contain three capture
    groups for the three variables, in order. It must match the entire read name. e.g. if field names
    were separated by semi-colon ('';'') this example regex could be specified (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$
    Note that if no READ_NAME_REGEX is specified, the read name is split on '':''. For 5 element names,
    the 3rd, 4th and 5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA
    1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values.'
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
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file.
  inputBinding:
    position: 101
    prefix: --REFERENCE_SEQUENCE
- id: remove_duplicates
  type:
  - 'null'
  - boolean
  doc: If true do not write duplicates to the output file instead of writing them with appropriate flags
    set.
  inputBinding:
    position: 101
    prefix: --REMOVE_DUPLICATES
    valueFrom: '$(self === null ? null : String(self))'
- id: remove_sequencing_duplicates
  type:
  - 'null'
  - boolean
  doc: If true remove 'optical' duplicates and other duplicates that appear to have arisen from the sequencing
    process instead of the library preparation process, even if REMOVE_DUPLICATES is false. If REMOVE_DUPLICATES
    is true, all duplicates are removed and this option is ignored.
  inputBinding:
    position: 101
    prefix: --REMOVE_SEQUENCING_DUPLICATES
    valueFrom: '$(self === null ? null : String(self))'
- id: sorting_collection_size_ratio
  type:
  - 'null'
  - float
  doc: This number, plus the maximum RAM available to the JVM, determine the memory footprint used by
    some of the sorting collections. If you are running out of memory, try reducing this number.
  inputBinding:
    position: 101
    prefix: --SORTING_COLLECTION_SIZE_RATIO
- id: tag_duplicate_set_members
  type:
  - 'null'
  - boolean
  doc: If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG (DS),
    indicates the size of the duplicate set. The smallest possible DS value is 2 which occurs when two
    reads map to the same portion of the reference only one of which is marked as duplicate. The second
    tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier for the duplicate set to which the
    record belongs. This identifier is the index-in-file of the representative read that was selected
    out of the duplicate set.
  inputBinding:
    position: 101
    prefix: --TAG_DUPLICATE_SET_MEMBERS
    valueFrom: '$(self === null ? null : String(self))'
- id: tagging_policy
  type:
  - 'null'
  - string
  doc: 'Determines how duplicate types are recorded in the DT optional attribute. Possible values: {DontTag,
    OpticalOnly, All}'
  inputBinding:
    position: 101
    prefix: --TAGGING_POLICY
- id: tmp_dir
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --TMP_DIR
  doc: One or more directories with space available to be used by this program for temporary storage of
    working files
  inputBinding:
    position: 101
- id: umi_tag_name
  type:
  - 'null'
  - string
  doc: Tag name to use for UMI
  inputBinding:
    position: 101
    prefix: --UMI_TAG_NAME
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  inputBinding:
    position: 101
    prefix: --USE_JDK_DEFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  inputBinding:
    position: 101
    prefix: --USE_JDK_INFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: validation_stringency
  type:
  - 'null'
  - string
  doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
    improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
    do not otherwise need to be decoded. Possible values: {STRICT, LENIENT, SILENT}'
  inputBinding:
    position: 101
    prefix: --VALIDATION_STRINGENCY
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --VERBOSITY
- id: java_options
  type:
  - 'null'
  - string
  doc: Java options for the GATK launcher, for example -Xmx4g
  inputBinding:
    position: 101
    prefix: --java-options
outputs:
- id: metrics_file_output
  type: File
  doc: File to write duplication metrics to
  outputBinding:
    glob: $(inputs.metrics_file)
- id: output_output
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
- id: umi_metrics_file_output
  type: File
  doc: UMI Metrics
  outputBinding:
    glob: $(inputs.umi_metrics_file)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
