cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectTargetedPcrMetrics
label: picard_CollectTargetedPcrMetrics
doc: Calculate PCR-related metrics from targeted sequencing data. This tool 
  calculates a set of PCR-related metrics from an aligned SAM or BAM file 
  containing targeted sequencing data.
inputs:
  - id: amplicon_intervals
    type: File
    doc: An interval list file that contains the locations of the baits used.
    inputBinding:
      position: 101
      prefix: --AMPLICON_INTERVALS
  - id: input
    type:
      - 'null'
      - File
    doc: An aligned SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output file to write the metrics to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: target_intervals
    type:
      - 'null'
      - type: array
        items: File
    doc: An interval list file that contains the locations of the targets. This 
      argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --TARGET_INTERVALS
  - id: allele_fraction
    type:
      - 'null'
      - type: array
        items: float
    doc: Allele fraction for which to calculate theoretical sensitivity.
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
  - id: clip_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: True if we are to clip overlapping reads, false otherwise.
    inputBinding:
      position: 101
      prefix: --CLIP_OVERLAPPING_READS
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: coverage_cap
    type:
      - 'null'
      - int
    doc: Parameter to set a max coverage limit for Theoretical Sensitivity 
      calculations.
    inputBinding:
      position: 101
      prefix: --COVERAGE_CAP
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
  - id: custom_amplicon_set_name
    type:
      - 'null'
      - string
    doc: Custom amplicon set name. If not provided it is inferred from the 
      filename of the AMPLICON_INTERVALS intervals.
    inputBinding:
      position: 101
      prefix: --CUSTOM_AMPLICON_SET_NAME
  - id: include_indels
    type:
      - 'null'
      - boolean
    doc: If true count inserted bases as on target and deleted bases as covered 
      by a read.
    inputBinding:
      position: 101
      prefix: --INCLUDE_INDELS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: metric_accumulation_level
    type:
      - 'null'
      - type: array
        items: string
    doc: The level(s) at which to accumulate metrics.
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for a base to contribute coverage.
    inputBinding:
      position: 101
      prefix: --MINIMUM_BASE_QUALITY
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to contribute coverage.
    inputBinding:
      position: 101
      prefix: --MINIMUM_MAPPING_QUALITY
  - id: near_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between a read and the nearest probe/bait/amplicon
      for the read to be considered 'near probe'.
    inputBinding:
      position: 101
      prefix: --NEAR_DISTANCE
  - id: per_base_coverage
    type: string
    doc: An optional file to output per base coverage information to.
    inputBinding:
      position: 101
      prefix: --PER_BASE_COVERAGE
  - id: per_target_coverage
    type: string
    doc: An optional file to output per target coverage information to.
    inputBinding:
      position: 101
      prefix: --PER_TARGET_COVERAGE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
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
    inputBinding:
      position: 101
      prefix: --SAMPLE_SIZE
  - id: theoretical_sensitivity_output
    type: string
    doc: Output for Theoretical Sensitivity metrics where the allele fractions 
      are provided by the ALLELE_FRACTION argument.
    inputBinding:
      position: 101
      prefix: --THEORETICAL_SENSITIVITY_OUTPUT
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
    doc: Validation stringency for all SAM files read by this program.
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
  - id: output_output
    type: File
    doc: The output file to write the metrics to.
    outputBinding:
      glob: $(inputs.output)
  - id: output_per_base_coverage
    type:
      - 'null'
      - File
    doc: An optional file to output per base coverage information to.
    outputBinding:
      glob: $(inputs.per_base_coverage)
  - id: output_per_target_coverage
    type:
      - 'null'
      - File
    doc: An optional file to output per target coverage information to.
    outputBinding:
      glob: $(inputs.per_target_coverage)
  - id: output_theoretical_sensitivity_output
    type:
      - 'null'
      - File
    doc: Output for Theoretical Sensitivity metrics where the allele fractions 
      are provided by the ALLELE_FRACTION argument.
    outputBinding:
      glob: $(inputs.theoretical_sensitivity_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
