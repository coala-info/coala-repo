cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectRrbsMetrics
label: picard_CollectRrbsMetrics
doc: Collects metrics from reduced representation bisulfite sequencing (Rrbs) 
  data. This tool uses reduced representation bisulfite sequencing (Rrbs) data 
  to determine cytosine methylation status across all reads of a genomic DNA 
  sequence.
inputs:
  - id: input
    type: File
    doc: The SAM/BAM/CRAM file containing aligned reads. Must be coordinate 
      sorted
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: metrics_file_prefix
    type: string
    doc: Base name for output files
    inputBinding:
      position: 101
      prefix: --METRICS_FILE_PREFIX
  - id: reference
    type:
      - 'null'
      - File
    doc: The reference sequence fasta file
    inputBinding:
      position: 101
      prefix: --REFERENCE
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
    doc: If true, assume that the input file is coordinate sorted even if the 
      header says otherwise.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
  - id: c_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for base quality of a C base before it is considered
    inputBinding:
      position: 101
      prefix: --C_QUALITY_THRESHOLD
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
  - id: max_mismatch_rate
    type:
      - 'null'
      - float
    doc: Maximum percentage of mismatches in a read for it to be considered, 
      with a range of 0-1
    inputBinding:
      position: 101
      prefix: --MAX_MISMATCH_RATE
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
    doc: The level(s) at which to accumulate metrics.
    inputBinding:
      position: 101
      prefix: --METRIC_ACCUMULATION_LEVEL
  - id: minimum_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 101
      prefix: --MINIMUM_READ_LENGTH
  - id: next_base_quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for quality of a base next to a C before the C base is 
      considered
    inputBinding:
      position: 101
      prefix: --NEXT_BASE_QUALITY_THRESHOLD
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: sequence_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Set of sequence names to consider, if not specified all sequences will 
      be used
    inputBinding:
      position: 101
      prefix: --SEQUENCE_NAMES
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
    doc: Validation stringency for all SAM files read by this program.
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
  - id: output_metrics_file_prefix
    type: File
    doc: Base name for output files
    outputBinding:
      glob: $(inputs.metrics_file_prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
