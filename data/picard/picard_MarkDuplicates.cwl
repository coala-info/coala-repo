cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - MarkDuplicates
label: picard_MarkDuplicates
doc: Identifies duplicate reads. This tool locates and tags duplicate reads in a
  SAM, BAM or CRAM file, where duplicate reads are defined as originating from a
  single fragment of DNA. MarkDuplicates also produces a metrics file indicating
  the numbers of duplicates for both single- and paired-end reads.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: One or more input SAM, BAM or CRAM files to analyze. Must be coordinate
      sorted.
    inputBinding:
      position: 101
      prefix: --INPUT
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
    doc: Add PG tag to each read in a SAM or BAM
    inputBinding:
      position: 101
      prefix: --ADD_PG_TAG_TO_READS
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
    doc: 'If not null, assume that the input file has this order even if the header
      says otherwise. Possible values: {unsorted, queryname, coordinate, duplicate,
      unknown}'
    inputBinding:
      position: 101
      prefix: --ASSUME_SORT_ORDER
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true, assume that the input file is coordinate sorted even if the 
      header says otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate 
      instead.
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
    doc: Clear DT tag from input SAM records. Should be set to false if input 
      SAM doesn't have this tag.
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
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: duplex_umi
    type:
      - 'null'
      - boolean
    doc: Treat UMIs as being duplex stranded.
    inputBinding:
      position: 101
      prefix: --DUPLEX_UMI
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: The scoring strategy for choosing the non-duplicate among candidates.
    inputBinding:
      position: 101
      prefix: --DUPLICATE_SCORING_STRATEGY
  - id: flow_dup_strategy
    type:
      - 'null'
      - string
    doc: Use specific quality summing strategy for flow based reads.
    inputBinding:
      position: 101
      prefix: --FLOW_DUP_STRATEGY
  - id: flow_effective_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for considering a quality value high enough to be included 
      when calculating FLOW_QUALITY_SUM_STRATEGY calculation.
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
  - id: flow_q_is_known_end
    type:
      - 'null'
      - boolean
    doc: Treat position of read trimming based on quality as the known end 
      (relevant for flow based reads).
    inputBinding:
      position: 101
      prefix: --FLOW_Q_IS_KNOWN_END
  - id: flow_skip_first_n_flows
    type:
      - 'null'
      - int
    doc: Skip first N flows, starting from the read's start, when considering 
      duplicates.
    inputBinding:
      position: 101
      prefix: --FLOW_SKIP_FIRST_N_FLOWS
  - id: flow_unpaired_end_uncertainty
    type:
      - 'null'
      - int
    doc: Maximal difference of the read end position that counted as equal.
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_END_UNCERTAINTY
  - id: flow_unpaired_start_uncertainty
    type:
      - 'null'
      - int
    doc: Maximal difference of the read start position that counted as equal.
    inputBinding:
      position: 101
      prefix: --FLOW_UNPAIRED_START_UNCERTAINTY
  - id: flow_use_end_in_unpaired_reads
    type:
      - 'null'
      - boolean
    doc: Make the end location of single end read be significant when 
      considering duplicates, in addition to the start location.
    inputBinding:
      position: 101
      prefix: --FLOW_USE_END_IN_UNPAIRED_READS
  - id: flow_use_unpaired_clipped_end
    type:
      - 'null'
      - boolean
    doc: Use position of the clipping as the end position, when considering 
      duplicates.
    inputBinding:
      position: 101
      prefix: --FLOW_USE_UNPAIRED_CLIPPED_END
  - id: max_file_handles_for_read_ends_map
    type:
      - 'null'
      - int
    doc: Maximum number of file handles to keep open when spilling read ends to 
      disk.
    inputBinding:
      position: 101
      prefix: --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP
  - id: max_optical_duplicate_set_size
    type:
      - 'null'
      - int
    doc: This number is the maximum size of a set of duplicate reads for which 
      we will attempt to determine which are optical duplicates.
    inputBinding:
      position: 101
      prefix: --MAX_OPTICAL_DUPLICATE_SET_SIZE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
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
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: Regular expression to extract tile/region, x coordinate and y 
      coordinate from a read name.
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
    inputBinding:
      position: 101
      prefix: --REMOVE_DUPLICATES
  - id: remove_sequencing_duplicates
    type:
      - 'null'
      - boolean
    doc: If true remove 'optical' duplicates and other duplicates that appear to
      have arisen from the sequencing process.
    inputBinding:
      position: 101
      prefix: --REMOVE_SEQUENCING_DUPLICATES
  - id: sorting_collection_size_ratio
    type:
      - 'null'
      - float
    doc: This number, plus the maximum RAM available to the JVM, determine the 
      memory footprint used by some of the sorting collections.
    inputBinding:
      position: 101
      prefix: --SORTING_COLLECTION_SIZE_RATIO
  - id: tag_duplicate_set_members
    type:
      - 'null'
      - boolean
    doc: If a read appears in a duplicate set, add two tags (DS and DI).
    inputBinding:
      position: 101
      prefix: --TAG_DUPLICATE_SET_MEMBERS
  - id: tagging_policy
    type:
      - 'null'
      - string
    doc: 'Determines how duplicate types are recorded in the DT optional attribute.
      Possible values: {DontTag, OpticalOnly, All}'
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
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_metrics_file
    type: File
    doc: File to write duplication metrics to
    outputBinding:
      glob: $(inputs.metrics_file)
  - id: output_output
    type: File
    doc: The output file to write marked records to
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
