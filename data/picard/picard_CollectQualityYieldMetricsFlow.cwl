cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectQualityYieldMetricsFlow
label: picard_CollectQualityYieldMetricsFlow
doc: "Collect metrics about reads that pass quality thresholds from flow based read
  files. This tool evaluates the overall quality of reads within a bam file containing
  one read group. The output indicates the total numbers of flows within a read group
  that pass a minimum base quality score threshold\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: flow_fill_empty_bins_value
    type:
      - 'null'
      - float
    doc: Value to fill the zeros of the matrix with
    default: 0.0
    inputBinding:
      position: 101
      prefix: --flow-fill-empty-bins-value
  - id: flow_ignore_t0_tag
    type:
      - 'null'
      - boolean
    doc: Ignore t0 tag in the read when create flow matrix (arcane/obsolete)
    default: false
    inputBinding:
      position: 101
      prefix: --flow-ignore-t0-tag
  - id: include_bq_histogram
    type:
      - 'null'
      - boolean
    doc: Determines whether to include the flow quality histogram in the metrics
      file.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_BQ_HISTOGRAM
  - id: include_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: If true, include bases from secondary alignments in metrics. Setting to
      true may cause double-counting of bases if there are secondary alignments 
      in the input file.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_SECONDARY_ALIGNMENTS
  - id: include_supplemental_alignments
    type:
      - 'null'
      - boolean
    doc: If true, include bases from supplemental alignments in metrics. Setting
      to true may cause double-counting of bases if there are supplemental 
      alignments in the input file.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_SUPPLEMENTAL_ALIGNMENTS
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
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
  - id: output
    type: File
    doc: The file to write the output to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
