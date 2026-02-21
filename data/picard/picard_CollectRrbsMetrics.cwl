cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectRrbsMetrics
label: picard_CollectRrbsMetrics
doc: "Collects metrics from reduced representation bisulfite sequencing (Rrbs) data.
  This tool uses Rrbs data to determine cytosine methylation status across all reads
  of a genomic DNA sequence.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true, assume that the input file is coordinate sorted even if the 
      header says otherwise.
    default: false
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
  - id: c_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for base quality of a C base before it is considered
    default: 20
    inputBinding:
      position: 101
      prefix: --C_QUALITY_THRESHOLD
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
    type: File
    doc: The SAM/BAM/CRAM file containing aligned reads. Must be coordinate 
      sorted
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: max_mismatch_rate
    type:
      - 'null'
      - float
    doc: Maximum percentage of mismatches in a read for it to be considered, 
      with a range of 0-1
    default: 0.1
    inputBinding:
      position: 101
      prefix: --MAX_MISMATCH_RATE
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
  - id: metric_accumulation_level
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The level(s) at which to accumulate metrics. Possible values: {ALL_READS,
      SAMPLE, LIBRARY, READ_GROUP}'
    default: ALL_READS
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: minimum_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    default: 5
    inputBinding:
      position: 101
      prefix: --MINIMUM_READ_LENGTH
  - id: next_base_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for quality of a base next to a C before the C base is 
      considered
    default: 10
    inputBinding:
      position: 101
      prefix: --NEXT_BASE_QUALITY_THRESHOLD
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference
    type: File
    doc: The reference sequence fasta file
    inputBinding:
      position: 101
      prefix: --REFERENCE
  - id: sequence_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Set of sequence names to consider, if not specified all sequences will 
      be used
    inputBinding:
      position: 101
      prefix: --SEQUENCE_NAMES
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
  - id: metrics_file_prefix
    type: File
    doc: Base name for output files
    outputBinding:
      glob: $(inputs.metrics_file_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
