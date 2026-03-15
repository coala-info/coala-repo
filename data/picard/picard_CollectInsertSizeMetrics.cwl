cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectInsertSizeMetrics
label: picard_CollectInsertSizeMetrics
doc: Collect metrics about the insert size distribution of a paired-end library.
  This tool provides useful metrics for validating library construction 
  including the insert size distribution and read orientation of paired-end 
  libraries.
inputs:
  - id: histogram_file
    type: string
    doc: File to write insert size Histogram chart to.
    inputBinding:
      position: 101
      prefix: --Histogram_FILE
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
    doc: The file to write the output to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
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
    doc: If true (default), then the sort order in the header file will be 
      ignored.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
  - id: deviations
    type:
      - 'null'
      - float
    doc: Generate mean, sd and plots by trimming the data down to MEDIAN + 
      DEVIATIONS*MEDIAN_ABSOLUTE_DEVIATION.
    inputBinding:
      position: 101
      prefix: --DEVIATIONS
  - id: histogram_width
    type:
      - 'null'
      - int
    doc: Explicitly sets the Histogram width, overriding automatic truncation of
      Histogram tail.
    inputBinding:
      position: 101
      prefix: --HISTOGRAM_WIDTH
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: If true, also include reads marked as duplicates in the insert size 
      histogram.
    inputBinding:
      position: 101
      prefix: --INCLUDE_DUPLICATES
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
    doc: 'The level(s) at which to accumulate metrics. Possible values: {ALL_READS,
      SAMPLE, LIBRARY, READ_GROUP}'
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: min_histogram_width
    type:
      - 'null'
      - int
    doc: Minimum width of histogram plots.
    inputBinding:
      position: 101
      prefix: --MIN_HISTOGRAM_WIDTH
  - id: minimum_pct
    type:
      - 'null'
      - float
    doc: 'When generating the Histogram, discard any data categories (out of FR, TANDEM,
      RF) that have fewer than this percentage of overall reads. (Range: 0 to 1).'
    inputBinding:
      position: 101
      prefix: --MINIMUM_PCT
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
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop after processing N reads, mainly for debugging.
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
  - id: output_histogram_file
    type: File
    doc: File to write insert size Histogram chart to.
    outputBinding:
      glob: $(inputs.histogram_file)
  - id: output_output
    type: File
    doc: The file to write the output to.
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
