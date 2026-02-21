cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectHiSeqXPfFailMetrics
label: picard_CollectHiSeqXPfFailMetrics
doc: "Classify PF-Failing reads in a HiSeqX Illumina Basecalling directory into various
  categories. This tool categorizes the reads that did not pass filter (PF-Failing)
  into four groups: MISALIGNED, EMPTY, POLYCLONAL, and UNKNOWN.\n\nTool homepage:
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
  - id: basecalls_dir
    type: Directory
    doc: The Illumina basecalls directory.
    inputBinding:
      position: 101
      prefix: --BASECALLS_DIR
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
  - id: lane
    type: int
    doc: Lane number.
    inputBinding:
      position: 101
      prefix: --LANE
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
  - id: n_cycles
    type:
      - 'null'
      - int
    doc: Number of cycles to look at. At time of writing PF status gets 
      determined at cycle 24.
    default: 24
    inputBinding:
      position: 101
      prefix: --N_CYCLES
  - id: num_processors
    type:
      - 'null'
      - int
    doc: Run this many PerTileBarcodeExtractors in parallel.
    default: 1
    inputBinding:
      position: 101
      prefix: --NUM_PROCESSORS
  - id: prob_explicit_reads
    type:
      - 'null'
      - float
    doc: The fraction of (non-PF) reads for which to output explicit 
      classification. Output file will be <OUTPUT>.pffail_detailed_metrics (if 
      PROB_EXPLICIT_READS != 0)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --PROB_EXPLICIT_READS
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
    type: File
    doc: Basename for metrics file. Resulting file will be 
      <OUTPUT>.pffail_summary_metrics
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
