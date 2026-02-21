cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectRnaSeqMetrics
label: picard_CollectRnaSeqMetrics
doc: "Produces RNA alignment metrics for a SAM or BAM file. This tool takes a SAM/BAM
  file containing the aligned reads from an RNAseq experiment and produces metrics
  describing the distribution of the bases within the transcripts.\n\nTool homepage:
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
  - id: end_bias_bases
    type:
      - 'null'
      - int
    doc: The distance into a transcript over which 5' and 3' bias is calculated.
    default: 100
    inputBinding:
      position: 101
      prefix: --END_BIAS_BASES
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
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: When calculating coverage based values (e.g. CV of coverage) only use 
      transcripts of this length or greater.
    default: 500
    inputBinding:
      position: 101
      prefix: --MINIMUM_LENGTH
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
    type: File
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
  - id: ribosomal_intervals
    type:
      - 'null'
      - File
    doc: Location of rRNA sequences in genome, in interval_list format.
    inputBinding:
      position: 101
      prefix: --RIBOSOMAL_INTERVALS
  - id: rrna_fragment_percentage
    type:
      - 'null'
      - float
    doc: This percentage of the length of a fragment must overlap one of the 
      ribosomal intervals for a read or read pair to be considered rRNA.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --RRNA_FRAGMENT_PERCENTAGE
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
  - id: strand_specificity
    type: string
    doc: 'For strand-specific library prep. Possible values: {NONE, FIRST_READ_TRANSCRIPTION_STRAND,
      SECOND_READ_TRANSCRIPTION_STRAND}'
    inputBinding:
      position: 101
      prefix: --STRAND_SPECIFICITY
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
  - id: chart_output
    type:
      - 'null'
      - File
    doc: The PDF file to write out a plot of normalized position vs. coverage.
    outputBinding:
      glob: $(inputs.chart_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
