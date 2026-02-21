cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectSamErrorMetrics
label: picard_CollectSamErrorMetrics
doc: "Program to collect error metrics on bases stratified in various ways. To estimate
  the error rate the tool assumes that all differences from the reference are errors.
  For this to be a reasonable assumption the tool needs to know the sites at which
  the sample is actually polymorphic and a confidence interval where the user is relatively
  certain that the polymorphic sites are known and accurate. These two inputs are
  provided as a VCF and INTERVALS.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: error_metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: Errors to collect in the form of "ERROR(:STRATIFIER)*".
    inputBinding:
      position: 101
      prefix: --ERROR_METRICS
  - id: error_value
    type:
      - 'null'
      - string
    doc: A fake argument used to show the options of ERROR (in ERROR_METRICS).
    inputBinding:
      position: 101
      prefix: --ERROR_VALUE
  - id: file_extension
    type:
      - 'null'
      - string
    doc: Append the given file extension to all metric file names.
    inputBinding:
      position: 101
      prefix: --FILE_EXTENSION
  - id: input
    type: File
    doc: Input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: interval_iterator
    type:
      - 'null'
      - boolean
    doc: Iterate through the file assuming it consists of a pre-created subset 
      interval of the full genome.
    default: false
    inputBinding:
      position: 101
      prefix: --INTERVAL_ITERATOR
  - id: intervals
    type:
      - 'null'
      - type: array
        items: File
    doc: Region(s) to limit analysis to. Supported formats are VCF or 
      interval_list.
    inputBinding:
      position: 101
      prefix: --INTERVALS
  - id: location_bin_size
    type:
      - 'null'
      - int
    doc: Size of location bins. Used by the FLOWCELL_X and FLOWCELL_Y 
      stratifiers
    default: 2500
    inputBinding:
      position: 101
      prefix: --LOCATION_BIN_SIZE
  - id: long_homopolymer
    type:
      - 'null'
      - int
    doc: Shortest homopolymer which is considered long. Used by the 
      BINNED_HOMOPOLYMER stratifier.
    default: 6
    inputBinding:
      position: 101
      prefix: --LONG_HOMOPOLYMER
  - id: max_loci
    type:
      - 'null'
      - int
    doc: Maximum number of loci to process (or unlimited if 0).
    default: 0
    inputBinding:
      position: 101
      prefix: --MAX_LOCI
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
  - id: min_base_q
    type:
      - 'null'
      - int
    doc: Minimum base quality to include base.
    default: 20
    inputBinding:
      position: 101
      prefix: --MIN_BASE_Q
  - id: min_mapping_q
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to include read.
    default: 20
    inputBinding:
      position: 101
      prefix: --MIN_MAPPING_Q
  - id: prior_q
    type:
      - 'null'
      - int
    doc: The prior error, in phred-scale (used for calculating empirical error 
      rates).
    default: 30
    inputBinding:
      position: 101
      prefix: --PRIOR_Q
  - id: probability
    type:
      - 'null'
      - float
    doc: The probability of selecting a locus for analysis (for downsampling).
    default: 1.0
    inputBinding:
      position: 101
      prefix: --PROBABILITY
  - id: progress_step_interval
    type:
      - 'null'
      - int
    doc: The interval between which progress will be displayed.
    default: 100000
    inputBinding:
      position: 101
      prefix: --PROGRESS_STEP_INTERVAL
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference_sequence
    type: File
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
  - id: stratifier_value
    type:
      - 'null'
      - string
    doc: A fake argument used to show the options of STRATIFIER (in 
      ERROR_METRICS).
    inputBinding:
      position: 101
      prefix: --STRATIFIER_VALUE
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
    doc: Validation stringency for all SAM files read by this program.
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF of known variation for sample. program will skip over polymorphic 
      sites in this VCF and avoid collecting data on these loci.
    inputBinding:
      position: 101
      prefix: --VCF
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
  - id: output
    type: File
    doc: Base name for output files. Actual file names will be generated from 
      the basename and suffixes from the ERROR and STRATIFIER.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
