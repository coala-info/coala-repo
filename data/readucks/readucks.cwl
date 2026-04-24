cwlVersion: v1.2
class: CommandLineTool
baseCommand: readucks
label: readucks
doc: "Readucks: a simple demuxing tool for nanopore data.\n\nTool homepage: https://github.com/artic-network/readucks"
inputs:
  - id: adapter_threshold
    type:
      - 'null'
      - int
    doc: 'Identity required for a barcode to be included after filtering (default:
      90)'
    inputBinding:
      position: 101
      prefix: --adapter_threshold
  - id: annotate_files
    type:
      - 'null'
      - boolean
    doc: 'Writes a CSV file for each input file containing barcode calls for each
      read. (default: False)'
    inputBinding:
      position: 101
      prefix: --annotate_files
  - id: bin_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Reads will be binned based on their barcode and saved to separate files.
      (default: False)'
    inputBinding:
      position: 101
      prefix: --bin_barcodes
  - id: check_reads
    type:
      - 'null'
      - int
    doc: 'Number of barcodes to classify before filtering barcode set (default: 1000)'
    inputBinding:
      position: 101
      prefix: --check_reads
  - id: extended_info
    type:
      - 'null'
      - boolean
    doc: 'Writes extended information about barcode calls. (default: False)'
    inputBinding:
      position: 101
      prefix: --extended_info
  - id: input_path
    type: File
    doc: FASTQ of input reads or a directory which will be recursively searched 
      for FASTQ files (required).
    inputBinding:
      position: 101
      prefix: --input
  - id: limit_barcodes_to
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a list of barcodes to look for (numbers refer to native, PCR or
      rapid)
    inputBinding:
      position: 101
      prefix: --limit_barcodes_to
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Demuxing mode, one of ["stringent","lenient","porechop"]. (default: porechop)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: native_barcodes
    type:
      - 'null'
      - boolean
    doc: Only attempts to match the 24 native barcodes (default)
    inputBinding:
      position: 101
      prefix: --native_barcodes
  - id: num_reads_in_batch
    type:
      - 'null'
      - int
    doc: 'The number of reads to process (and hold in memory) at a time (default:
      200)'
    inputBinding:
      position: 101
      prefix: --num_reads_in_batch
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: working directory)'
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: pcr_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Only attempts to match the 96 PCR barcodes (default: False)'
    inputBinding:
      position: 101
      prefix: --pcr_barcodes
  - id: prefix
    type:
      - 'null'
      - string
    doc: Optional prefix to file names
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rapid_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Only attempts to match the 12 rapid barcodes (default: False)'
    inputBinding:
      position: 101
      prefix: --rapid_barcodes
  - id: report_alternate_call
    type:
      - 'null'
      - boolean
    doc: 'Reports double/single barcode call to csv in single/double barcoding mode
      (default: False)'
    inputBinding:
      position: 101
      prefix: --report_alternate_call
  - id: require_two_barcodes
    type:
      - 'null'
      - boolean
    doc: Match barcodes at both ends of read (default single)
    inputBinding:
      position: 101
      prefix: --require_two_barcodes
  - id: score_diff
    type:
      - 'null'
      - float
    doc: 'The second barcode must have at least this percent identity (and match the
      first one) (default: 5)'
    inputBinding:
      position: 101
      prefix: --score_diff
  - id: scoring_scheme
    type:
      - 'null'
      - string
    doc: 'Comma-delimited string of alignment scores: match, mismatch, gap open, gap
      extend (default: 3,-6,-5,-2)'
    inputBinding:
      position: 101
      prefix: --scoring_scheme
  - id: secondary_threshold
    type:
      - 'null'
      - float
    doc: 'The second barcode must have at least this percent identity (and match the
      first one) (default: 65)'
    inputBinding:
      position: 101
      prefix: --secondary_threshold
  - id: summary_info
    type:
      - 'null'
      - boolean
    doc: 'Writes another file with information about barcode calls. (default: False)'
    inputBinding:
      position: 101
      prefix: --summary_info
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use (1 to turn off multithreading) (default: 2)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'A read must have at least this percent identity to a barcode (default: 75)'
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Level of output information: 0 = none, 1 = some, 2 = lots (default: 1)'
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readucks:0.0.3--py_0
stdout: readucks.out
