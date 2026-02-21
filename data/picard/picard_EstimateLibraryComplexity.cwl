cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - EstimateLibraryComplexity
label: picard_EstimateLibraryComplexity
doc: "Estimates the numbers of unique molecules in a sequencing library. Library complexity
  refers to the number of unique DNA fragments present in a given library. Reductions
  in complexity resulting from PCR amplification during library preparation will ultimately
  compromise downstream analyses via an elevation in the number of duplicate reads.\n\
  \nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Barcode SAM tag (ex. BC for 10X Genomics)
    inputBinding:
      position: 101
      prefix: --BARCODE_TAG
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
  - id: input
    type:
      type: array
      items: File
    doc: One or more files to combine and estimate library complexity from. 
      Reads can be mapped or unmapped. This argument must be specified at least 
      once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: max_diff_rate
    type:
      - 'null'
      - float
    doc: The maximum rate of differences between two reads to call them 
      identical.
    default: 0.03
    inputBinding:
      position: 101
      prefix: --MAX_DIFF_RATE
  - id: max_group_ratio
    type:
      - 'null'
      - int
    doc: Do not process self-similar groups that are this many times over the 
      mean expected group size.
    default: 500
    inputBinding:
      position: 101
      prefix: --MAX_GROUP_RATIO
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
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: The maximum number of bases to consider when comparing reads (0 means 
      no maximum).
    default: 0
    inputBinding:
      position: 101
      prefix: --MAX_READ_LENGTH
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    default: 2279706
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_group_count
    type:
      - 'null'
      - int
    doc: Minimum number group count. On a per-library basis, we count the number
      of groups of duplicates that have a particular size. Omit from 
      consideration any count that is less than this value.
    default: 2
    inputBinding:
      position: 101
      prefix: --MIN_GROUP_COUNT
  - id: min_identical_bases
    type:
      - 'null'
      - int
    doc: The minimum number of bases at the starts of reads that must be 
      identical for reads to be grouped together for duplicate detection.
    default: 5
    inputBinding:
      position: 101
      prefix: --MIN_IDENTICAL_BASES
  - id: min_mean_quality
    type:
      - 'null'
      - int
    doc: The minimum mean quality of the bases in a read pair for the read to be
      analyzed.
    default: 20
    inputBinding:
      position: 101
      prefix: --MIN_MEAN_QUALITY
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
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
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
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: output
    type: File
    doc: Output file to writes per-library metrics to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
