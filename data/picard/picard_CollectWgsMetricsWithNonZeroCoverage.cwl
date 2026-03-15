cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectWgsMetricsWithNonZeroCoverage
label: picard_CollectWgsMetricsWithNonZeroCoverage
doc: Collect metrics about coverage and performance of whole genome sequencing 
  (WGS) experiments. This tool collects metrics about the percentages of reads 
  that pass base- and mapping- quality filters as well as coverage (read-depth) 
  levels. This extends CollectWgsMetrics by including metrics related only to 
  sites with non-zero (>0) coverage.
inputs:
  - id: chart_output
    type: string
    doc: A file (with .pdf extension) to write the chart to.
    inputBinding:
      position: 101
      prefix: --CHART_OUTPUT
  - id: input
    type:
      - 'null'
      - File
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: Output metrics file.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: allele_fraction
    type:
      - 'null'
      - type: array
        items: float
    doc: Allele fraction for which to calculate theoretical sensitivity. This 
      argument may be specified 0 or more times.
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
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: count_unpaired
    type:
      - 'null'
      - boolean
    doc: If true, count unpaired reads, and paired reads with one end unmapped
    inputBinding:
      position: 101
      prefix: --COUNT_UNPAIRED
  - id: coverage_cap
    type:
      - 'null'
      - int
    doc: Treat positions with coverage exceeding this value as if they had 
      coverage at this value (but calculate the difference for PCT_EXC_CAPPED).
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
  - id: include_bq_histogram
    type:
      - 'null'
      - boolean
    doc: Determines whether to include the base quality histogram in the metrics
      file.
    inputBinding:
      position: 101
      prefix: --INCLUDE_BQ_HISTOGRAM
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
      reads that accumulate beyond this value.
    inputBinding:
      position: 101
      prefix: --LOCUS_ACCUMULATION_CAP
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_length
    type:
      - 'null'
      - int
    doc: Average read length in the file. Default is 150.
    inputBinding:
      position: 101
      prefix: --READ_LENGTH
  - id: sample_size
    type:
      - 'null'
      - int
    doc: Sample Size used for Theoretical Het Sensitivity sampling. Default is 
      10000.
    inputBinding:
      position: 101
      prefix: --SAMPLE_SIZE
  - id: stop_after
    type:
      - 'null'
      - int
    doc: For debugging purposes, stop after processing this many genomic bases.
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
  - id: theoretical_sensitivity_output
    type: string
    doc: Output for Theoretical Sensitivity metrics.
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
  - id: use_fast_algorithm
    type:
      - 'null'
      - boolean
    doc: If true, fast algorithm is used.
    inputBinding:
      position: 101
      prefix: --USE_FAST_ALGORITHM
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
  - id: output_chart_output
    type: File
    doc: A file (with .pdf extension) to write the chart to.
    outputBinding:
      glob: $(inputs.chart_output)
  - id: output_output
    type: File
    doc: Output metrics file.
    outputBinding:
      glob: $(inputs.output)
  - id: output_theoretical_sensitivity_output
    type:
      - 'null'
      - File
    doc: Output for Theoretical Sensitivity metrics.
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
