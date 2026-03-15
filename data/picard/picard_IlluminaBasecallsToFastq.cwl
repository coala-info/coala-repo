cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - IlluminaBasecallsToFastq
label: picard_IlluminaBasecallsToFastq
doc: Generate FASTQ file(s) from Illumina basecall read data. This tool 
  generates FASTQ files from data in an Illumina BaseCalls output directory. 
  Separate FASTQ files are created for each template, barcode, and index 
  (molecular barcode) read.
inputs:
  - id: basecalls_dir
    type: Directory
    doc: The Illumina basecalls directory.
    inputBinding:
      position: 101
      prefix: --BASECALLS_DIR
  - id: lane
    type:
      type: array
      items: int
    doc: Lane number. This can be specified multiple times. Reads with the same 
      index in multiple lanes will be added to the same output file.
    inputBinding:
      position: 101
      prefix: --LANE
  - id: multiplex_params
    type:
      - 'null'
      - File
    doc: Tab-separated file for creating all output FASTQs demultiplexed by 
      barcode for a lane with single IlluminaBasecallsToFastq invocation. Cannot
      be used in conjunction with OUTPUT_PREFIX.
    inputBinding:
      position: 101
      prefix: --MULTIPLEX_PARAMS
  - id: output_prefix
    type: string
    doc: The prefix for output FASTQs. Extensions as described above are 
      appended. Cannot be used in conjunction with MULTIPLEX_PARAMS.
    inputBinding:
      position: 101
      prefix: --OUTPUT_PREFIX
  - id: read_structure
    type: string
    doc: A description of the logical structure of clusters in an Illumina Run 
      (e.g. 28T8M8B8S28T).
    inputBinding:
      position: 101
      prefix: --READ_STRUCTURE
  - id: run_barcode
    type: string
    doc: The barcode of the run. Prefixed to read names.
    inputBinding:
      position: 101
      prefix: --RUN_BARCODE
  - id: adapters_to_check
    type:
      - 'null'
      - type: array
        items: string
    doc: Which adapters to look for in the reads.
    inputBinding:
      position: 101
      prefix: --ADAPTERS_TO_CHECK
  - id: apply_eamss_filter
    type:
      - 'null'
      - boolean
    doc: Apply EAMSS filtering to identify inappropriately quality scored bases 
      towards the ends of reads.
    inputBinding:
      position: 101
      prefix: --APPLY_EAMSS_FILTER
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: barcodes_dir
    type:
      - 'null'
      - Directory
    doc: The barcodes directory with _barcode.txt files. If not set, use 
      BASECALLS_DIR.
    inputBinding:
      position: 101
      prefix: --BARCODES_DIR
  - id: compress_outputs
    type:
      - 'null'
      - boolean
    doc: Compress output FASTQ files using gzip and append a .gz extension to 
      the file names.
    inputBinding:
      position: 101
      prefix: --COMPRESS_OUTPUTS
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created.
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
  - id: distance_mode
    type:
      - 'null'
      - string
    doc: The distance metric that should be used to compare the barcode-reads 
      and the provided barcodes.
    inputBinding:
      position: 101
      prefix: --DISTANCE_MODE
  - id: first_tile
    type:
      - 'null'
      - int
    doc: If set, this is the first tile to be processed (used for debugging).
    inputBinding:
      position: 101
      prefix: --FIRST_TILE
  - id: five_prime_adapter
    type:
      - 'null'
      - string
    doc: For specifying adapters other than standard Illumina
    inputBinding:
      position: 101
      prefix: --FIVE_PRIME_ADAPTER
  - id: flowcell_barcode
    type:
      - 'null'
      - string
    doc: The barcode of the flowcell that was sequenced; required if emitting 
      Casava1.8-style read name headers
    inputBinding:
      position: 101
      prefix: --FLOWCELL_BARCODE
  - id: force_gc
    type:
      - 'null'
      - boolean
    doc: If true, call System.gc() periodically.
    inputBinding:
      position: 101
      prefix: --FORCE_GC
  - id: ignore_unexpected_barcodes
    type:
      - 'null'
      - boolean
    doc: Whether to ignore reads whose barcodes are not found in 
      MULTIPLEX_PARAMS.
    inputBinding:
      position: 101
      prefix: --IGNORE_UNEXPECTED_BARCODES
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: Whether to include non-PF reads
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PF_READS
  - id: input_params_file
    type:
      - 'null'
      - File
    doc: The input file that defines parameters for the program.
    inputBinding:
      position: 101
      prefix: --INPUT_PARAMS_FILE
  - id: machine_name
    type:
      - 'null'
      - string
    doc: The name of the machine on which the run was sequenced; required if 
      emitting Casava1.8-style read name headers
    inputBinding:
      position: 101
      prefix: --MACHINE_NAME
  - id: match_barcodes_inline
    type:
      - 'null'
      - boolean
    doc: If true, match barcodes on the fly. Otherwise parse the barcodes from 
      the barcodes file.
    inputBinding:
      position: 101
      prefix: --MATCH_BARCODES_INLINE
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches for a barcode to be considered a match.
    inputBinding:
      position: 101
      prefix: --MAX_MISMATCHES
  - id: max_no_calls
    type:
      - 'null'
      - int
    doc: Maximum allowable number of no-calls in a barcode read before it is 
      considered unmatchable.
    inputBinding:
      position: 101
      prefix: --MAX_NO_CALLS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: metrics_file
    type: string
    doc: Per-barcode and per-lane metrics written to this file.
    inputBinding:
      position: 101
      prefix: --METRICS_FILE
  - id: min_mismatch_delta
    type:
      - 'null'
      - int
    doc: Minimum difference between number of mismatches in the best and second 
      best barcodes for a barcode to be considered a match.
    inputBinding:
      position: 101
      prefix: --MIN_MISMATCH_DELTA
  - id: min_trimmed_length
    type:
      - 'null'
      - int
    doc: The minimum length for a trimmed read.
    inputBinding:
      position: 101
      prefix: --MIN_TRIMMED_LENGTH
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality. Any barcode bases falling below this quality will
      be considered a mismatch.
    inputBinding:
      position: 101
      prefix: --MINIMUM_BASE_QUALITY
  - id: minimum_quality
    type:
      - 'null'
      - int
    doc: The minimum quality (after transforming 0s to 1s) expected from reads.
    inputBinding:
      position: 101
      prefix: --MINIMUM_QUALITY
  - id: num_processors
    type:
      - 'null'
      - int
    doc: The number of threads to run in parallel.
    inputBinding:
      position: 101
      prefix: --NUM_PROCESSORS
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_name_format
    type:
      - 'null'
      - string
    doc: The read name header formatting to emit.
    inputBinding:
      position: 101
      prefix: --READ_NAME_FORMAT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sort
    type:
      - 'null'
      - boolean
    doc: If true, the output records are sorted by read name.
    inputBinding:
      position: 101
      prefix: --SORT
  - id: three_prime_adapter
    type:
      - 'null'
      - string
    doc: For specifying adapters other than standard Illumina
    inputBinding:
      position: 101
      prefix: --THREE_PRIME_ADAPTER
  - id: tile_limit
    type:
      - 'null'
      - int
    doc: If set, process no more than this many tiles (used for debugging).
    inputBinding:
      position: 101
      prefix: --TILE_LIMIT
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
  - id: trimming_quality
    type:
      - 'null'
      - int
    doc: The quality to use as a threshold for trimming.
    inputBinding:
      position: 101
      prefix: --TRIMMING_QUALITY
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
  - id: output_output_prefix
    type: File
    doc: The prefix for output FASTQs. Extensions as described above are 
      appended. Cannot be used in conjunction with MULTIPLEX_PARAMS.
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_metrics_file
    type:
      - 'null'
      - File
    doc: Per-barcode and per-lane metrics written to this file.
    outputBinding:
      glob: $(inputs.metrics_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
