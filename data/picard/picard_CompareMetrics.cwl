cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CompareMetrics
label: picard_CompareMetrics
doc: "Compare two metrics files. This tool compares the metrics and histograms generated
  from metric tools to determine if the generated results are identical. Note that
  if there are differences in metric values, this tool describes those differences
  as the change of the second input metric relative to the first.\n\nTool homepage:
  http://broadinstitute.github.io/picard/"
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
  - id: ignore_histogram_differences
    type:
      - 'null'
      - boolean
    doc: Ignore any differences between the two metric file's histograms (useful
      if using the 'METRIC_ALLOWABLE_RELATIVE_CHANGE')
    default: false
    inputBinding:
      position: 101
      prefix: --IGNORE_HISTOGRAM_DIFFERENCES
  - id: input
    type:
      type: array
      items: File
    doc: Metric files to compare. This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: key
    type:
      - 'null'
      - type: array
        items: string
    doc: Columns to use as keys for matching metrics rows that should agree. If 
      not specified, it is assumed that rows should be in the same order.
    inputBinding:
      position: 101
      prefix: --KEY
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
  - id: metric_allowable_relative_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Metric Allowable Relative Change. A colon separate pair of metric name 
      and an absolute relative change.
    inputBinding:
      position: 101
      prefix: --METRIC_ALLOWABLE_RELATIVE_CHANGE
  - id: metrics_not_required
    type:
      - 'null'
      - type: array
        items: string
    doc: Metrics which are not required. Any metrics specified here may be 
      missing from either of the files in the comparison, and this will not 
      affect the result of the comparison.
    inputBinding:
      position: 101
      prefix: --METRICS_NOT_REQUIRED
  - id: metrics_to_ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: Metrics to ignore. Any metrics specified here will be excluded from 
      comparison by the tool.
    inputBinding:
      position: 101
      prefix: --METRICS_TO_IGNORE
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
    type:
      - 'null'
      - File
    doc: Output file to write comparison results to.
    outputBinding:
      glob: $(inputs.output)
  - id: output_table
    type:
      - 'null'
      - File
    doc: Output file to write table of differences to.
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
