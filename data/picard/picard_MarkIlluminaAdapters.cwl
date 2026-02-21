cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - MarkIlluminaAdapters
label: picard_MarkIlluminaAdapters
doc: "Reads a SAM/BAM/CRAM file and rewrites it with new adapter-trimming tags. This
  tool clears any existing adapter-trimming tags (XT:i:) in the optional tag region
  of the input file. The SAM/BAM/CRAM file must be sorted by query name. Outputs a
  metrics file histogram showing counts of bases_clipped per read.\n\nTool homepage:
  http://broadinstitute.github.io/picard/"
inputs:
  - id: adapter_truncation_length
    type:
      - 'null'
      - int
    doc: Adapters are truncated to this length to speed adapter matching. Set to
      a large number to effectively disable truncation.
    default: 30
    inputBinding:
      position: 101
      prefix: --ADAPTER_TRUNCATION_LENGTH
  - id: adapters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Which adapters sequences to attempt to identify and clip. Possible values:
      {PAIRED_END, INDEXED, SINGLE_END, NEXTERA_V1, NEXTERA_V2, DUAL_INDEXED, FLUIDIGM,
      TRUSEQ_SMALLRNA, ALTERNATIVE_SINGLE_END}'
    default:
      - INDEXED
      - DUAL_INDEXED
      - PAIRED_END
    inputBinding:
      position: 101
      prefix: --ADAPTERS
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
  - id: five_prime_adapter
    type:
      - 'null'
      - string
    doc: For specifying adapters other than standard Illumina
    inputBinding:
      position: 101
      prefix: --FIVE_PRIME_ADAPTER
  - id: input
    type: File
    doc: Undocumented option
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: max_error_rate_pe
    type:
      - 'null'
      - float
    doc: The maximum mismatch error rate to tolerate when clipping paired-end 
      reads.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --MAX_ERROR_RATE_PE
  - id: max_error_rate_se
    type:
      - 'null'
      - float
    doc: The maximum mismatch error rate to tolerate when clipping single-end 
      reads.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --MAX_ERROR_RATE_SE
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
  - id: min_match_bases_pe
    type:
      - 'null'
      - int
    doc: The minimum number of bases to match over (per-read) when clipping 
      paired-end reads.
    default: 6
    inputBinding:
      position: 101
      prefix: --MIN_MATCH_BASES_PE
  - id: min_match_bases_se
    type:
      - 'null'
      - int
    doc: The minimum number of bases to match over when clipping single-end 
      reads.
    default: 12
    inputBinding:
      position: 101
      prefix: --MIN_MATCH_BASES_SE
  - id: num_adapters_to_keep
    type:
      - 'null'
      - int
    doc: If pruning the adapter list, keep only this many adapter sequences when
      pruning the list (plus any adapters that were tied with the adapters being
      kept).
    default: 1
    inputBinding:
      position: 101
      prefix: --NUM_ADAPTERS_TO_KEEP
  - id: paired_run
    type:
      - 'null'
      - boolean
    doc: DEPRECATED. Whether this is a paired-end run. No longer used.
    inputBinding:
      position: 101
      prefix: --PAIRED_RUN
  - id: prune_adapter_list_after_this_many_adapters_seen
    type:
      - 'null'
      - int
    doc: If looking for multiple adapter sequences, then after having seen this 
      many adapters, shorten the list of sequences. Keep the adapters that were 
      found most frequently in the input so far.
    default: 100
    inputBinding:
      position: 101
      prefix: --PRUNE_ADAPTER_LIST_AFTER_THIS_MANY_ADAPTERS_SEEN
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
  - id: three_prime_adapter
    type:
      - 'null'
      - string
    doc: For specifying adapters other than standard Illumina
    inputBinding:
      position: 101
      prefix: --THREE_PRIME_ADAPTER
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
  - id: metrics
    type: File
    doc: Histogram showing counts of bases_clipped in how many reads
    outputBinding:
      glob: $(inputs.metrics)
  - id: output
    type:
      - 'null'
      - File
    doc: If output is not specified, just the metrics are generated
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
