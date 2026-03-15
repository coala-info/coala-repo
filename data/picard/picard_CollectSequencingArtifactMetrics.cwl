cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectSequencingArtifactMetrics
label: picard_CollectSequencingArtifactMetrics
doc: 'Collect metrics to quantify single-base sequencing artifacts. This tool examines
  two sources of sequencing errors associated with hybrid selection protocols: pre-adapter
  and bait-bias.'
inputs:
  - id: input
    type: File
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
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
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
  - id: context_size
    type:
      - 'null'
      - int
    doc: The number of context bases to include on each side of the assayed 
      base.
    inputBinding:
      position: 101
      prefix: --CONTEXT_SIZE
  - id: contexts_to_print
    type:
      - 'null'
      - type: array
        items: string
    doc: If specified, only print results for these contexts in the detail 
      metrics output.
    inputBinding:
      position: 101
      prefix: --CONTEXTS_TO_PRINT
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
  - id: db_snp
    type:
      - 'null'
      - File
    doc: VCF format dbSNP file, used to exclude regions around known 
      polymorphisms from analysis.
    inputBinding:
      position: 101
      prefix: --DB_SNP
  - id: file_extension
    type:
      - 'null'
      - string
    doc: Append the given file extension to all metric file names (ex. 
      OUTPUT.pre_adapter_summary_metrics.EXT).
    inputBinding:
      position: 101
      prefix: --FILE_EXTENSION
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: Include duplicate reads. If set to true then all reads flagged as 
      duplicates will be included as well.
    inputBinding:
      position: 101
      prefix: --INCLUDE_DUPLICATES
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: Whether or not to include non-PF reads.
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PF_READS
  - id: include_unpaired
    type:
      - 'null'
      - boolean
    doc: Include unpaired reads. If set to true then all paired reads will be 
      included as well - MINIMUM_INSERT_SIZE and MAXIMUM_INSERT_SIZE will be 
      ignored.
    inputBinding:
      position: 101
      prefix: --INCLUDE_UNPAIRED
  - id: intervals
    type:
      - 'null'
      - File
    doc: An optional list of intervals to restrict analysis to.
    inputBinding:
      position: 101
      prefix: --INTERVALS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: maximum_insert_size
    type:
      - 'null'
      - int
    doc: The maximum insert size for a read to be included in analysis. Set to 0
      to have no maximum.
    inputBinding:
      position: 101
      prefix: --MAXIMUM_INSERT_SIZE
  - id: minimum_insert_size
    type:
      - 'null'
      - int
    doc: The minimum insert size for a read to be included in analysis.
    inputBinding:
      position: 101
      prefix: --MINIMUM_INSERT_SIZE
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: The minimum mapping quality score for a base to be included in 
      analysis.
    inputBinding:
      position: 101
      prefix: --MINIMUM_MAPPING_QUALITY
  - id: minimum_quality_score
    type:
      - 'null'
      - int
    doc: The minimum base quality score for a base to be included in analysis.
    inputBinding:
      position: 101
      prefix: --MINIMUM_QUALITY_SCORE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop after processing N reads, mainly for debugging.
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
  - id: tandem_reads
    type:
      - 'null'
      - boolean
    doc: Set to true if mate pairs are being sequenced from the same strand, 
      i.e. they're expected to face the same direction.
    inputBinding:
      position: 101
      prefix: --TANDEM_READS
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
  - id: use_oq
    type:
      - 'null'
      - boolean
    doc: When available, use original quality scores for filtering.
    inputBinding:
      position: 101
      prefix: --USE_OQ
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
