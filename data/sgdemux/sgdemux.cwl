cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgdemux
label: sgdemux
doc: "Performs sample demultiplexing on block-compressed (BGZF) FASTQs.\n\nTool homepage:
  https://github.com/Singular-Genomics/singular-demux"
inputs:
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches between the observed barcode and the 
      expected barcode
    default: 1
    inputBinding:
      position: 101
      prefix: --allowed-mismatches
  - id: compressor_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for compression the output reads.\n\n            The number
      of threads to use for compressing reads that are queued for writing."
    default: 12
    inputBinding:
      position: 101
      prefix: --compressor-threads
  - id: demux_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for demultiplexing.\n\n            The number of threads
      to use for the process of determining which input reads should be assigned to
      which sample."
    default: 4
    inputBinding:
      position: 101
      prefix: --demux-threads
  - id: fastqs
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the input FASTQs, or path prefix if not a file
    inputBinding:
      position: 101
      prefix: --fastqs
  - id: filter_control_reads
    type:
      - 'null'
      - boolean
    doc: Filter out control reads
    inputBinding:
      position: 101
      prefix: --filter-control-reads
  - id: filter_failing_quality
    type:
      - 'null'
      - boolean
    doc: Filter reads failing quality filter
    inputBinding:
      position: 101
      prefix: --filter-failing-quality
  - id: free_ns
    type:
      - 'null'
      - int
    doc: Number of N's to allow in a barcode without counting against the 
      allowed_mismatches
    default: 1
    inputBinding:
      position: 101
      prefix: --free-ns
  - id: lane
    type:
      - 'null'
      - type: array
        items: string
    doc: Select a subset of lanes to demultiplex.  Will cause only samples and 
      input FASTQs with the given `Lane`(s) to be demultiplexed.  Samples 
      without a lane will be ignored, and FASTQs without lane information will 
      be ignored
    inputBinding:
      position: 101
      prefix: --lane
  - id: max_no_calls
    type:
      - 'null'
      - string
    doc: "Max no-calls (N's) in a barcode before it is considered unmatchable.\n\n\
      \            A barcode with total N's greater than `max_no_call` will be considered
      unmatchable."
    default: None
    inputBinding:
      position: 101
      prefix: --max-no-calls
  - id: metric_prefix
    type:
      - 'null'
      - string
    doc: Prepend this prefix to all output metric file names
    inputBinding:
      position: 101
      prefix: --metric-prefix
  - id: min_delta
    type:
      - 'null'
      - int
    doc: The minimum allowed difference between an observed barcode and the 
      second closest expected barcode
    default: 2
    inputBinding:
      position: 101
      prefix: --min-delta
  - id: most_unmatched_to_output
    type:
      - 'null'
      - int
    doc: "Output the most frequent \"unmatched\" barcodes up to this number.\n\n \
      \           If set to 0 unmatched barcodes will not be collected, improving
      overall performance."
    default: 1000
    inputBinding:
      position: 101
      prefix: --most-unmatched-to-output
  - id: output_types
    type:
      - 'null'
      - string
    doc: "The types of output FASTQs to write.\n\n            These may be any of
      the following:\n            - `T` - Template bases\n            - `B` - Sample
      barcode bases\n            - `M` - Molecular barcode bases\n            - `S`
      - Skip bases\n            \n            For each read structure, all segment
      types listed by `--output-types` will be output to a\n            FASTQ file."
    default: T
    inputBinding:
      position: 101
      prefix: --output-types
  - id: override_matcher
    type:
      - 'null'
      - string
    doc: "Override the matcher heuristic.\n\n            If the sample barcodes are
      > 12 bp long, a cached hamming distance matcher is used. If the barcodes are
      less than or equal to 12 bp long, all possible matches are precomputed.\n  \
      \          \n            This option allows for overriding that heuristic."
    default: None
    inputBinding:
      position: 101
      prefix: --override-matcher
  - id: quality_mask_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: "Mask template bases with quality scores less than specified value(s).\n\n\
      \            Sample barcode/index and UMI bases are never masked. If provided
      either a single value, or one value per FASTQ must be provided."
    inputBinding:
      position: 101
      prefix: --quality-mask-threshold
  - id: read_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: Read structures, one per input FASTQ. Do not provide when using a path 
      prefix for FASTQs
    inputBinding:
      position: 101
      prefix: --read-structures
  - id: sample_barcode_in_fastq_header
    type:
      - 'null'
      - boolean
    doc: If this is true, then the sample barcode is expected to be in the FASTQ
      read header.  For dual indexed data, the barcodes must be `+` (plus) 
      delimited.  Additionally, if true, then neither index FASTQ files nor 
      sample barcode segments in the read structure may be specified
    inputBinding:
      position: 101
      prefix: --sample-barcode-in-fastq-header
  - id: sample_metadata
    type: File
    doc: Path to the sample metadata
    inputBinding:
      position: 101
      prefix: --sample-metadata
  - id: skip_read_name_check
    type:
      - 'null'
      - boolean
    doc: If this is true, then all the read names across FASTQs will not be 
      enforced to be the same. This may be useful when the read names are known 
      to be the same and performance matters. Regardless, the first read name in
      each FASTQ will always be checked
    inputBinding:
      position: 101
      prefix: --skip-read-name-check
  - id: undetermined_sample_name
    type:
      - 'null'
      - string
    doc: The sample name for undetermined reads (reads that do not match an 
      expected barcode)
    default: Undetermined
    inputBinding:
      position: 101
      prefix: --undetermined-sample-name
  - id: writer_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for writing compressed reads to output.\n\n          \
      \  The number of threads to have writing reads to their individual output files."
    default: 5
    inputBinding:
      position: 101
      prefix: --writer-threads
outputs:
  - id: output_dir
    type: Directory
    doc: "The directory to write outputs to.\n\n            This tool will overwrite
      existing files."
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sgdemux:1.2.0--h3ab6199_4
