cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ExtractIlluminaBarcodes
label: picard_ExtractIlluminaBarcodes
doc: Tool determines the barcode for each read in an Illumina lane. This tool 
  determines the numbers of reads containing barcode-matching sequences and 
  provides statistics on the quality of these barcode matches.
inputs:
  - id: barcode
    type:
      type: array
      items: string
    doc: Barcode sequence. These must be unique, and all the same length. This 
      cannot be used with reads that have more than one barcode; use 
      BARCODE_FILE in that case. This argument must be specified at least once. 
      Required unless BARCODE_FILE is provided.
    inputBinding:
      position: 101
      prefix: --BARCODE
  - id: barcode_file
    type: File
    doc: Tab-delimited file of barcode sequences, barcode name and, optionally, 
      library name. Barcodes must be unique and all the same length. Required 
      unless BARCODE is provided.
    inputBinding:
      position: 101
      prefix: --BARCODE_FILE
  - id: basecalls_dir
    type:
      - 'null'
      - Directory
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
  - id: read_structure
    type: string
    doc: A description of the logical structure of clusters in an Illumina Run 
      (e.g. 28T8M8B8S28T).
    inputBinding:
      position: 101
      prefix: --READ_STRUCTURE
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: distance_mode
    type:
      - 'null'
      - string
    doc: The distance metric that should be used to compare the barcode-reads 
      and the provided barcodes (HAMMING, LENIENT_HAMMING, or FREE).
    inputBinding:
      position: 101
      prefix: --DISTANCE_MODE
  - id: input_params_file
    type:
      - 'null'
      - File
    doc: The input file that defines parameters for the program.
    inputBinding:
      position: 101
      prefix: --INPUT_PARAMS_FILE
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
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality. Any barcode bases falling below this quality will
      be considered a mismatch even if the bases match.
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
    doc: Run this many PerTileBarcodeExtractors in parallel.
    inputBinding:
      position: 101
      prefix: --NUM_PROCESSORS
  - id: output_dir
    type: string
    doc: Where to write _barcode.txt files. By default, these are written to 
      BASECALLS_DIR.
    inputBinding:
      position: 101
      prefix: --OUTPUT_DIR
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
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
    doc: Validation stringency for all SAM files read by this program (STRICT, 
      LENIENT, or SILENT).
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
  - id: output_metrics_file
    type:
      - 'null'
      - File
    doc: Per-barcode and per-lane metrics written to this file.
    outputBinding:
      glob: $(inputs.metrics_file)
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Where to write _barcode.txt files. By default, these are written to 
      BASECALLS_DIR.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
