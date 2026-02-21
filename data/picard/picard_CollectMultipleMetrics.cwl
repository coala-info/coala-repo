cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectMultipleMetrics
label: picard_CollectMultipleMetrics
doc: "Collect multiple classes of metrics. This 'meta-metrics' tool runs one or more
  of the metrics collection modules at the same time to cut down on the time spent
  reading in data from input files.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: db_snp
    type:
      - 'null'
      - File
    doc: VCF format dbSNP file, used to exclude regions around known 
      polymorphisms from analysis by some PROGRAMs.
    inputBinding:
      position: 101
      prefix: --DB_SNP
  - id: extra_argument
    type:
      - 'null'
      - type: array
        items: string
    doc: extra arguments to the various tools can be specified using the 
      following format:<PROGRAM>::<ARGUMENT_AND_VALUE>
    inputBinding:
      position: 101
      prefix: --EXTRA_ARGUMENT
  - id: file_extension
    type:
      - 'null'
      - string
    doc: Append the given file extension to all metric file names (ex. 
      OUTPUT.insert_size_metrics.EXT).
    inputBinding:
      position: 101
      prefix: --FILE_EXTENSION
  - id: ignore_sequence
    type:
      - 'null'
      - type: array
        items: string
    doc: If a read maps to a sequence specified with this option, all the bases 
      in the read are counted as ignored bases.
    inputBinding:
      position: 101
      prefix: --IGNORE_SEQUENCE
  - id: include_unpaired
    type:
      - 'null'
      - boolean
    doc: Include unpaired reads in CollectSequencingArtifactMetrics.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_UNPAIRED
  - id: input
    type: File
    doc: Input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: intervals
    type:
      - 'null'
      - File
    doc: An optional list of intervals to restrict analysis to. Only pertains to
      some of the PROGRAMs.
    inputBinding:
      position: 101
      prefix: --INTERVALS
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
  - id: program
    type:
      - 'null'
      - type: array
        items: string
    doc: Set of metrics programs to apply during the pass through the SAM file.
    default:
      - CollectAlignmentSummaryMetrics
      - CollectBaseDistributionByCycle
      - CollectInsertSizeMetrics
      - MeanQualityByCycle
      - QualityScoreDistribution
    inputBinding:
      position: 101
      prefix: --PROGRAM
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: ref_flat
    type:
      - 'null'
      - File
    doc: Gene annotations in refFlat form.
    inputBinding:
      position: 101
      prefix: --REF_FLAT
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
    doc: Base name of output files.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
