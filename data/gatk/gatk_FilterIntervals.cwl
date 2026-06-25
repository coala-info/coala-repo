cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FilterIntervals
label: gatk_FilterIntervals
doc: Filters intervals based on annotations and/or count statistics
inputs:
  - id: intervals
    type:
      type: array
      items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: output
    type: string
    doc: Output Picard interval-list file containing the filtered intervals.
    inputBinding:
      position: 101
      prefix: --output
  - id: annotated_intervals
    type:
      - 'null'
      - File
    doc: Input file containing annotations for genomic intervals (output of 
      AnnotateIntervals). Must be provided if no counts files are provided.
    inputBinding:
      position: 101
      prefix: --annotated-intervals
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: extreme_count_filter_maximum_percentile
    type:
      - 'null'
      - float
    doc: Maximum-percentile parameter for the extreme-count filter.
    inputBinding:
      position: 101
      prefix: --extreme-count-filter-maximum-percentile
  - id: extreme_count_filter_minimum_percentile
    type:
      - 'null'
      - float
    doc: Minimum-percentile parameter for the extreme-count filter.
    inputBinding:
      position: 101
      prefix: --extreme-count-filter-minimum-percentile
  - id: extreme_count_filter_percentage_of_samples
    type:
      - 'null'
      - float
    doc: Percentage-of-samples parameter for the extreme-count filter.
    inputBinding:
      position: 101
      prefix: --extreme-count-filter-percentage_of_samples
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input TSV or HDF5 files containing integer read counts in genomic 
      intervals (output of CollectReadCounts).
    inputBinding:
      position: 101
      prefix: --input
  - id: interval_exclusion_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are excluding.
    inputBinding:
      position: 101
      prefix: --interval-exclusion-padding
  - id: interval_merging_rule
    type:
      - 'null'
      - string
    doc: Interval merging rule for abutting intervals
    inputBinding:
      position: 101
      prefix: --interval-merging-rule
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are including.
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: Set merging approach to use for combining interval inputs
    inputBinding:
      position: 101
      prefix: --interval-set-rule
  - id: low_count_filter_count_threshold
    type:
      - 'null'
      - int
    doc: Count-threshold parameter for the low-count filter.
    inputBinding:
      position: 101
      prefix: --low-count-filter-count-threshold
  - id: low_count_filter_percentage_of_samples
    type:
      - 'null'
      - float
    doc: Percentage-of-samples parameter for the low-count filter.
    inputBinding:
      position: 101
      prefix: --low-count-filter-percentage-of-samples
  - id: maximum_gc_content
    type:
      - 'null'
      - float
    doc: Maximum allowed value for GC-content annotation (inclusive).
    inputBinding:
      position: 101
      prefix: --maximum-gc-content
  - id: maximum_mappability
    type:
      - 'null'
      - float
    doc: Maximum allowed value for mappability annotation (inclusive).
    inputBinding:
      position: 101
      prefix: --maximum-mappability
  - id: maximum_segmental_duplication_content
    type:
      - 'null'
      - float
    doc: Maximum allowed value for segmental-duplication-content annotation 
      (inclusive).
    inputBinding:
      position: 101
      prefix: --maximum-segmental-duplication-content
  - id: minimum_gc_content
    type:
      - 'null'
      - float
    doc: Minimum allowed value for GC-content annotation (inclusive).
    inputBinding:
      position: 101
      prefix: --minimum-gc-content
  - id: minimum_mappability
    type:
      - 'null'
      - float
    doc: Minimum allowed value for mappability annotation (inclusive).
    inputBinding:
      position: 101
      prefix: --minimum-mappability
  - id: minimum_segmental_duplication_content
    type:
      - 'null'
      - float
    doc: Minimum allowed value for segmental-duplication-content annotation 
      (inclusive).
    inputBinding:
      position: 101
      prefix: --minimum-segmental-duplication-content
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
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
    doc: Output Picard interval-list file containing the filtered intervals.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
