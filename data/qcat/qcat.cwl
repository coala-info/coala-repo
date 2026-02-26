cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcat
label: qcat
doc: "Python command-line tool for demultiplexing Oxford Nanopore reads from FASTQ
  files\n\nTool homepage: https://github.com/nanoporetech/qcat"
inputs:
  - id: barcode_dir
    type:
      - 'null'
      - Directory
    doc: If specified, qcat will demultiplex reads to this folder
    inputBinding:
      position: 101
      prefix: --barcode_dir
  - id: detect_middle
    type:
      - 'null'
      - boolean
    doc: Search for adapters in the whole read
    inputBinding:
      position: 101
      prefix: --detect-middle
  - id: dual
    type:
      - 'null'
      - boolean
    doc: Use dual barcoding algorithm
    inputBinding:
      position: 101
      prefix: --dual
  - id: epi2me
    type:
      - 'null'
      - boolean
    doc: Use EPI2ME's demultiplexing algorithm
    default: true
    inputBinding:
      position: 101
      prefix: --epi2me
  - id: fastq
    type:
      - 'null'
      - File
    doc: Barcoded read file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: filter_barcodes
    type:
      - 'null'
      - boolean
    doc: Filter rare barcode calls when run in batch mode
    inputBinding:
      position: 101
      prefix: --filter-barcodes
  - id: guppy
    type:
      - 'null'
      - boolean
    doc: Use Guppy's demultiplexing algorithm
    default: false
    inputBinding:
      position: 101
      prefix: --guppy
  - id: kit
    type:
      - 'null'
      - string
    doc: Sequencing kit. Specifying the correct kit will improve sensitivity and
      specificity and runtime
    default: auto
    inputBinding:
      position: 101
      prefix: --kit
  - id: list_kits
    type:
      - 'null'
      - boolean
    doc: List all supported kits
    inputBinding:
      position: 101
      prefix: --list-kits
  - id: log_file
    type:
      - 'null'
      - File
    doc: Print debug information
    inputBinding:
      position: 101
      prefix: --log
  - id: min_length
    type:
      - 'null'
      - int
    doc: Reads short than <min-read-length> after trimming will be discarded.
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum barcode score. Barcode calls with a lower score will be 
      discarded. Must be between 0 and 100.
    default: 60
    inputBinding:
      position: 101
      prefix: --min-score
  - id: no_batch
    type:
      - 'null'
      - boolean
    doc: Don't use information from multiple reads for kit detection
    default: false
    inputBinding:
      position: 101
      prefix: --no-batch
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print summary
    inputBinding:
      position: 101
      prefix: --quiet
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Use simple demultiplexing algorithm. Only looks for barcodes, not for 
      adapter sequences. Use only for testing purposes!
    inputBinding:
      position: 101
      prefix: --simple
  - id: simple_barcodes
    type:
      - 'null'
      - string
    doc: Use 12 (standard) or 96 (extended) barcodes for demultiplexing
    inputBinding:
      position: 101
      prefix: --simple-barcodes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Only works with in guppy mode
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Remove adapter and barcode sequences from reads.
    inputBinding:
      position: 101
      prefix: --trim
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Prints a tsv file containing barcode information each read to stdout.
    inputBinding:
      position: 101
      prefix: --tsv
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file trimmed reads will be written to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcat:1.1.0--py_0
