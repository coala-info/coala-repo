cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectGcBiasMetrics
label: picard_CollectGcBiasMetrics
doc: "Collects information about the relative proportions of guanine (G) and cytosine
  (C) nucleotides in a sample to assess GC bias.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: also_ignore_duplicates
    type:
      - 'null'
      - boolean
    doc: 'Use to get additional results without duplicates. This option allows to
      gain two plots per level at the same time: one is the usual one and the other
      excludes duplicates.'
    default: false
    inputBinding:
      position: 101
      prefix: --ALSO_IGNORE_DUPLICATES
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
    default: true
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: is_bisulfite_sequenced
    type:
      - 'null'
      - boolean
    doc: Whether the SAM or BAM file consists of bisulfite sequenced reads.
    default: false
    inputBinding:
      position: 101
      prefix: --IS_BISULFITE_SEQUENCED
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
  - id: minimum_genome_fraction
    type:
      - 'null'
      - float
    doc: For summary metrics, exclude GC windows that include less than this 
      fraction of the genome.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --MINIMUM_GENOME_FRACTION
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
  - id: scan_window_size
    type:
      - 'null'
      - int
    doc: The size of the scanning windows on the reference genome that are used 
      to bin reads.
    default: 100
    inputBinding:
      position: 101
      prefix: --SCAN_WINDOW_SIZE
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
    doc: Stop after processing N reads, mainly for debugging.
    default: 0
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
  - id: chart_output
    type: File
    doc: The PDF file to render the chart to.
    outputBinding:
      glob: $(inputs.chart_output)
  - id: output
    type: File
    doc: The file to write the output to.
    outputBinding:
      glob: $(inputs.output)
  - id: summary_output
    type: File
    doc: The text file to write summary metrics to.
    outputBinding:
      glob: $(inputs.summary_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
