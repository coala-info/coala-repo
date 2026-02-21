cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectRawWgsMetrics
label: picard_CollectRawWgsMetrics
doc: "Collect whole genome sequencing-related metrics. This tool computes metrics
  that are useful for evaluating coverage and performance of whole genome sequencing
  experiments. These metrics include the percentages of reads that pass minimal base-
  and mapping- quality filters as well as coverage (read-depth) levels.\n\nTool homepage:
  http://broadinstitute.github.io/picard/"
inputs:
  - id: allele_fraction
    type:
      - 'null'
      - type: array
        items: float
    doc: Allele fraction for which to calculate theoretical sensitivity. This 
      argument may be specified 0 or more times.
    default:
      - 0.001
      - 0.005
      - 0.01
      - 0.02
      - 0.05
      - 0.1
      - 0.2
      - 0.3
      - 0.5
    inputBinding:
      position: 101
      prefix: --ALLELE_FRACTION
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line This 
      argument may be specified 0 or more times.
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
  - id: count_unpaired
    type:
      - 'null'
      - boolean
    doc: If true, count unpaired reads, and paired reads with one end unmapped
    default: false
    inputBinding:
      position: 101
      prefix: --COUNT_UNPAIRED
  - id: coverage_cap
    type:
      - 'null'
      - int
    doc: Treat positions with coverage exceeding this value as if they had 
      coverage at this value (but calculate the difference for PCT_EXC_CAPPED).
    default: 100000
    inputBinding:
      position: 101
      prefix: --COVERAGE_CAP
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
  - id: include_bq_histogram
    type:
      - 'null'
      - boolean
    doc: Determines whether to include the base quality histogram in the metrics
      file.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_BQ_HISTOGRAM
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: intervals
    type:
      - 'null'
      - File
    doc: An interval list file that contains the positions to restrict the 
      assessment.
    inputBinding:
      position: 101
      prefix: --INTERVALS
  - id: locus_accumulation_cap
    type:
      - 'null'
      - int
    doc: At positions with coverage exceeding this value, completely ignore 
      reads that accumulate beyond this value (so that they will not be 
      considered for PCT_EXC_CAPPED).
    default: 200000
    inputBinding:
      position: 101
      prefix: --LOCUS_ACCUMULATION_CAP
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
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for a base to contribute coverage.
    default: 3
    inputBinding:
      position: 101
      prefix: --MINIMUM_BASE_QUALITY
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to contribute coverage.
    default: 0
    inputBinding:
      position: 101
      prefix: --MINIMUM_MAPPING_QUALITY
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_length
    type:
      - 'null'
      - int
    doc: Average read length in the file. Default is 150.
    default: 150
    inputBinding:
      position: 101
      prefix: --READ_LENGTH
  - id: reference_sequence
    type: File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sample_size
    type:
      - 'null'
      - int
    doc: Sample Size used for Theoretical Het Sensitivity sampling. Default is 
      10000.
    default: 10000
    inputBinding:
      position: 101
      prefix: --SAMPLE_SIZE
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: stop_after
    type:
      - 'null'
      - int
    doc: For debugging purposes, stop after processing this many genomic bases.
    default: -1
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
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
  - id: use_fast_algorithm
    type:
      - 'null'
      - boolean
    doc: If true, fast algorithm is used.
    default: false
    inputBinding:
      position: 101
      prefix: --USE_FAST_ALGORITHM
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
    doc: Output metrics file.
    outputBinding:
      glob: $(inputs.output)
  - id: theoretical_sensitivity_output
    type:
      - 'null'
      - File
    doc: Output for Theoretical Sensitivity metrics.
    outputBinding:
      glob: $(inputs.theoretical_sensitivity_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
