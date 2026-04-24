cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoplexer
label: nanoplexer
doc: "Demultiplexes Nanopore sequencing reads based on barcodes.\n\nTool homepage:
  https://github.com/hanyue36/nanoplexer"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: barcode_file
    type: File
    doc: Barcode file
    inputBinding:
      position: 102
      prefix: -b
  - id: batch_size
    type:
      - 'null'
      - string
    doc: Batch size
    inputBinding:
      position: 102
      prefix: -B
  - id: dual_barcode_file
    type:
      - 'null'
      - File
    doc: Dual barcode pair file
    inputBinding:
      position: 102
      prefix: -d
  - id: gap_extension_score
    type:
      - 'null'
      - int
    doc: Gap extension score
    inputBinding:
      position: 102
      prefix: -e
  - id: gap_open_score
    type:
      - 'null'
      - int
    doc: Gap open score
    inputBinding:
      position: 102
      prefix: -o
  - id: ignore_parameter_estimation
    type:
      - 'null'
      - boolean
    doc: Ignore parameter estimation
    inputBinding:
      position: 102
      prefix: -i
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    inputBinding:
      position: 102
      prefix: -m
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimal alignment score for demultiplexing
    inputBinding:
      position: 102
      prefix: -s
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Mismatch score
    inputBinding:
      position: 102
      prefix: -x
  - id: output_log_file
    type:
      - 'null'
      - File
    doc: Output log file
    inputBinding:
      position: 102
      prefix: -l
  - id: output_mode
    type:
      - 'null'
      - string
    doc: Output mode, fastq or fasta
    inputBinding:
      position: 102
      prefix: -M
  - id: output_path
    type: Directory
    doc: Output path
    inputBinding:
      position: 102
      prefix: -p
  - id: target_length
    type:
      - 'null'
      - int
    doc: Target length for detecting barcode
    inputBinding:
      position: 102
      prefix: -L
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplexer:0.1.2--h7132678_2
stdout: nanoplexer.out
