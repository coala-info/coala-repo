cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - MarkDuplicatesWithMateCigar
label: picard_MarkDuplicatesWithMateCigar
doc: Identifies duplicate reads, accounting for mate CIGAR. This tool locates 
  and tags duplicate reads (both PCR and optical) in a BAM, SAM or CRAM file, 
  where duplicate reads are defined as originating from the same original 
  fragment of DNA, taking into account the CIGAR string of read mates.
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
  - id: block_size
    type:
      - 'null'
      - int
    doc: The block size for use in the coordinate-sorted record buffer.
    inputBinding:
      position: 101
      prefix: --BLOCK_SIZE
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
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Possible
      values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
    inputBinding:
      position: 101
      prefix: --DUPLICATE_SCORING_STRATEGY
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
  - id: minimum_distance
    type:
      - 'null'
      - int
    doc: The minimum distance to buffer records to account for clipping on the 
      5' end of the records.
    inputBinding:
      position: 101
      prefix: --MINIMUM_DISTANCE
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
    doc: Value of CL tag of PG record to be created. If not supplied the command
      line will be detected automatically.
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
    doc: Regular expression to extract tile and x,y coordinates from a read name
      for optical duplicate detection.
    inputBinding:
      position: 101
      prefix: --READ_NAME_REGEX
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
  - id: skip_pairs_with_no_mate_cigar
    type:
      - 'null'
      - boolean
    doc: Skip record pairs with no mate cigar and include them in the output.
    inputBinding:
      position: 101
      prefix: --SKIP_PAIRS_WITH_NO_MATE_CIGAR
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
