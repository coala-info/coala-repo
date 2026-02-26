cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplexer
label: demultiplexer
doc: "Demultiplexes sequencing data based on barcodes.\n\nTool homepage: https://github.com/DominikBuchner/demultiplexer"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file containing multiplexed reads.
    inputBinding:
      position: 1
  - id: barcodes
    type: File
    doc: File containing the barcodes and their corresponding sample names.
    inputBinding:
      position: 2
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Allowed error rate for barcode matching.
    default: 0.1
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL).
    default: INFO
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_barcode_len
    type:
      - 'null'
      - int
    doc: Maximum length of the barcode to consider.
    default: 12
    inputBinding:
      position: 103
      prefix: --max-barcode-len
  - id: min_barcode_len
    type:
      - 'null'
      - int
    doc: Minimum length of the barcode to consider.
    default: 6
    inputBinding:
      position: 103
      prefix: --min-barcode-len
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the demultiplexed FASTQ files.
    default: .
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: unmatched_output
    type:
      - 'null'
      - File
    doc: FASTQ file to save reads that do not match any barcode.
    outputBinding:
      glob: $(inputs.unmatched_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/demultiplexer:1.2.1--pyhdfd78af_0
