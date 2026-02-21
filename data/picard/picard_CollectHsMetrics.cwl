cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectHsMetrics
label: picard_CollectHsMetrics
doc: "Collects hybrid-selection (HS) metrics for a SAM or BAM file. This tool takes
  a SAM/BAM file input and collects metrics that are specific for sequence datasets
  generated through hybrid-selection.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: allele_fraction
    type:
      - 'null'
      - type: array
        items: float
    doc: Allele fraction for which to calculate theoretical sensitivity.
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
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: bait_intervals
    type:
      type: array
      items: File
    doc: An interval list file that contains the locations of the baits used. 
      This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --BAIT_INTERVALS
  - id: bait_set_name
    type:
      - 'null'
      - string
    doc: Bait set name. If not provided it is inferred from the filename of the 
      bait intervals.
    inputBinding:
      position: 101
      prefix: --BAIT_SET_NAME
  - id: clip_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: True if we are to clip overlapping reads, false otherwise.
    default: true
    inputBinding:
      position: 101
      prefix: --CLIP_OVERLAPPING_READS
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: coverage_cap
    type:
      - 'null'
      - int
    doc: Parameter to set a max coverage limit for Theoretical Sensitivity 
      calculations.
    default: 200
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
  - id: include_indels
    type:
      - 'null'
      - boolean
    doc: If true count inserted bases as on target and deleted bases as covered 
      by a read.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_INDELS
  - id: input
    type: File
    doc: An aligned SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
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
    default:
      - ALL_READS
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for a base to contribute coverage.
    default: 20
    inputBinding:
      position: 101
      prefix: --MINIMUM_BASE_QUALITY
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to contribute coverage.
    default: 20
    inputBinding:
      position: 101
      prefix: --MINIMUM_MAPPING_QUALITY
  - id: near_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between a read and the nearest probe/bait/amplicon
      for the read to be considered 'near probe' and included in percent 
      selected.
    default: 250
    inputBinding:
      position: 101
      prefix: --NEAR_DISTANCE
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
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sample_size
    type:
      - 'null'
      - int
    doc: Sample Size used for Theoretical Het Sensitivity sampling.
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
  - id: target_intervals
    type:
      type: array
      items: File
    doc: An interval list file that contains the locations of the targets. This 
      argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --TARGET_INTERVALS
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
    doc: The output file to write the metrics to.
    outputBinding:
      glob: $(inputs.output)
  - id: per_base_coverage
    type:
      - 'null'
      - File
    doc: An optional file to output per base coverage information to.
    outputBinding:
      glob: $(inputs.per_base_coverage)
  - id: per_target_coverage
    type:
      - 'null'
      - File
    doc: An optional file to output per target coverage information to.
    outputBinding:
      glob: $(inputs.per_target_coverage)
  - id: theoretical_sensitivity_output
    type:
      - 'null'
      - File
    doc: Output for Theoretical Sensitivity metrics where the allele fractions 
      are provided by the ALLELE_FRACTION argument.
    outputBinding:
      glob: $(inputs.theoretical_sensitivity_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
