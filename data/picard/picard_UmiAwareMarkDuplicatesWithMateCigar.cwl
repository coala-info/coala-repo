cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - UmiAwareMarkDuplicatesWithMateCigar
label: picard_UmiAwareMarkDuplicatesWithMateCigar
doc: "Identifies duplicate reads using information from read positions and UMIs. This
  tool locates and tags duplicate reads in a BAM or SAM file, where duplicate reads
  are defined as originating from a single fragment of DNA. It leverages Unique Molecular
  Identifier (UMI) information and allows for sequencing errors in UMIs based on a
  maximum edit distance.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: add_pg_tag_to_reads
    type:
      - 'null'
      - boolean
    doc: Add PG tag to each read in a SAM or BAM
    default: true
    inputBinding:
      position: 101
      prefix: --ADD_PG_TAG_TO_READS
  - id: allow_missing_umis
    type:
      - 'null'
      - boolean
    doc: "FOR TESTING ONLY: allow for missing UMIs if data doesn't have UMIs."
    default: false
    inputBinding:
      position: 101
      prefix: --ALLOW_MISSING_UMIS
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: assume_sort_order
    type:
      - 'null'
      - string
    doc: If not null, assume that the input file has this order even if the 
      header says otherwise.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORT_ORDER
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true, assume that the input file is coordinate sorted even if the 
      header says otherwise. Deprecated.
    default: false
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
    doc: Clear DT tag from input SAM records.
    default: true
    inputBinding:
      position: 101
      prefix: --CLEAR_DT
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
    doc: Comment(s) to include in the output file's header.
    inputBinding:
      position: 101
      prefix: --COMMENT
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: duplex_umi
    type:
      - 'null'
      - boolean
    doc: Treat UMIs as being duplex stranded.
    default: false
    inputBinding:
      position: 101
      prefix: --DUPLEX_UMI
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: The scoring strategy for choosing the non-duplicate among candidates.
    default: SUM_OF_BASE_QUALITIES
    inputBinding:
      position: 101
      prefix: --DUPLICATE_SCORING_STRATEGY
  - id: flow_dup_strategy
    type:
      - 'null'
      - string
    doc: Use specific quality summing strategy for flow based reads.
    default: FLOW_QUALITY_SUM_STRATEGY
    inputBinding:
      position: 101
      prefix: --FLOW_DUP_STRATEGY
  - id: flow_effective_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for considering a quality value high enough to be included 
      when calculating FLOW_QUALITY_SUM_STRATEGY calculation.
    default: 15
    inputBinding:
      position: 101
      prefix: --FLOW_EFFECTIVE_QUALITY_THRESHOLD
  - id: flow_mode
    type:
      - 'null'
      - boolean
    doc: enable parameters and behavior specific to flow based reads.
    default: false
    inputBinding:
      position: 101
      prefix: --FLOW_MODE
  - id: flow_q_is_known_end
    type:
      - 'null'
      - boolean
    doc: Treat position of read trimming based on quality as the known end.
    default: false
    inputBinding:
      position: 101
      prefix: --FLOW_Q_IS_KNOWN_END
  - id: flow_skip_first_n_flows
    type:
      - 'null'
      - int
    doc: Skip first N flows, starting from the read's start, when considering 
      duplicates.
    default: 0
    inputBinding:
      position: 101
      prefix: --FLOW_SKIP_FIRST_N_FLOWS
  - id: flow_unpaired_end_uncertainty
    type:
      - 'null'
      - int
    doc: Maximal difference of the read end position that counted as equal.
    default: 0
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_END_UNCERTAINTY
  - id: flow_unpaired_start_uncertainty
    type:
      - 'null'
      - int
    doc: Maximal difference of the read start position that counted as equal.
    default: 0
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_START_UNCERTAINTY
  - id: flow_use_end_in_unpaired_reads
    type:
      - 'null'
      - boolean
    doc: Make the end location of single end read be significant when 
      considering duplicates.
    default: false
    inputBinding:
      position: 101
      prefix: --FLOW_USE_END_IN_UNPAIRED_READS
  - id: flow_use_unpaired_clipped_end
    type:
      - 'null'
      - boolean
    doc: Use position of the clipping as the end position, when considering 
      duplicates.
    default: false
    inputBinding:
      position: 101
      prefix: --FLOW_USE_UNPAIRED_CLIPPED_END
  - id: input
    type:
      type: array
      items: File
    doc: One or more input SAM, BAM or CRAM files to analyze. Must be coordinate
      sorted.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: max_edit_distance_to_join
    type:
      - 'null'
      - int
    doc: Largest edit distance that UMIs must have in order to be considered as 
      coming from distinct source molecules.
    default: 1
    inputBinding:
      position: 101
      prefix: --MAX_EDIT_DISTANCE_TO_JOIN
  - id: max_file_handles_for_read_ends_map
    type:
      - 'null'
      - int
    doc: Maximum number of file handles to keep open when spilling read ends to 
      disk.
    default: 8000
    inputBinding:
      position: 101
      prefix: --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP
  - id: max_optical_duplicate_set_size
    type:
      - 'null'
      - int
    doc: This number is the maximum size of a set of duplicate reads for which 
      we will attempt to determine which are optical duplicates.
    default: 300000
    inputBinding:
      position: 101
      prefix: --MAX_OPTICAL_DUPLICATE_SET_SIZE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    default: 500000
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: molecular_identifier_tag
    type:
      - 'null'
      - string
    doc: SAM tag to uniquely identify the molecule from which a read was 
      derived.
    inputBinding:
      position: 101
      prefix: --MOLECULAR_IDENTIFIER_TAG
  - id: optical_duplicate_pixel_distance
    type:
      - 'null'
      - int
    doc: The maximum offset between two duplicate clusters in order to consider 
      them optical duplicates.
    default: 100
    inputBinding:
      position: 101
      prefix: --OPTICAL_DUPLICATE_PIXEL_DISTANCE
  - id: program_group_command_line
    type:
      - 'null'
      - string
    doc: Value of CL tag of PG record to be created.
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_COMMAND_LINE
  - id: program_group_name
    type:
      - 'null'
      - string
    doc: Value of PN tag of PG record to be created.
    default: UmiAwareMarkDuplicatesWithMateCigar
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_NAME
  - id: program_group_version
    type:
      - 'null'
      - string
    doc: Value of VN tag of PG record to be created.
    inputBinding:
      position: 101
      prefix: --PROGRAM_GROUP_VERSION
  - id: program_record_id
    type:
      - 'null'
      - string
    doc: The program record ID for the @PG record(s) created by this program.
    default: MarkDuplicates
    inputBinding:
      position: 101
      prefix: --PROGRAM_RECORD_ID
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: Regular expression to extract tile and x,y coordinates from a read name
      for optical duplicate detection.
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
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: If true do not write duplicates to the output file instead of writing 
      them with appropriate flags set.
    default: false
    inputBinding:
      position: 101
      prefix: --REMOVE_DUPLICATES
  - id: remove_sequencing_duplicates
    type:
      - 'null'
      - boolean
    doc: If true remove 'optical' duplicates and other duplicates that appear to
      have arisen from the sequencing process.
    default: false
    inputBinding:
      position: 101
      prefix: --REMOVE_SEQUENCING_DUPLICATES
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: sorting_collection_size_ratio
    type:
      - 'null'
      - float
    doc: This number, plus the maximum RAM available to the JVM, determine the 
      memory footprint used by some of the sorting collections.
    default: 0.25
    inputBinding:
      position: 101
      prefix: --SORTING_COLLECTION_SIZE_RATIO
  - id: tag_duplicate_set_members
    type:
      - 'null'
      - boolean
    doc: If a read appears in a duplicate set, add two tags (DS and DI).
    default: false
    inputBinding:
      position: 101
      prefix: --TAG_DUPLICATE_SET_MEMBERS
  - id: tagging_policy
    type:
      - 'null'
      - string
    doc: Determines how duplicate types are recorded in the DT optional 
      attribute.
    default: DontTag
    inputBinding:
      position: 101
      prefix: --TAGGING_POLICY
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: umi_tag_name
    type:
      - 'null'
      - string
    doc: Tag name to use for UMI
    default: RX
    inputBinding:
      position: 101
      prefix: --UMI_TAG_NAME
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program.
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Control verbosity of logging.
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: metrics_file
    type: File
    doc: File to write duplication metrics to
    outputBinding:
      glob: $(inputs.metrics_file)
  - id: output
    type: File
    doc: The output file to write marked records to
    outputBinding:
      glob: $(inputs.output)
  - id: umi_metrics_file
    type: File
    doc: UMI Metrics
    outputBinding:
      glob: $(inputs.umi_metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
