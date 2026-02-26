cwlVersion: v1.2
class: CommandLineTool
baseCommand: calib
label: calib
doc: "Clustering without alignment using LSH and MinHashing of barcoded reads\n\n\
  Tool homepage: https://github.com/vpc-ccg/calib"
inputs:
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: Length of the barcode for both mates
    inputBinding:
      position: 101
      prefix: --barcode-length
  - id: barcode_length_1
    type:
      - 'null'
      - int
    doc: Length of the barcode for mate 1
    inputBinding:
      position: 101
      prefix: --barcode-length-1
  - id: barcode_length_2
    type:
      - 'null'
      - int
    doc: Length of the barcode for mate 2
    inputBinding:
      position: 101
      prefix: --barcode-length-2
  - id: error_tolerance
    type:
      - 'null'
      - int
    doc: Error tolerance for clustering
    default: Depends on observed read length
    inputBinding:
      position: 101
      prefix: --error-tolerance
  - id: gzip_input
    type:
      - 'null'
      - boolean
    doc: Input files are gzipped
    inputBinding:
      position: 101
      prefix: --gzip-input
  - id: ignored_sequence_prefix_length
    type:
      - 'null'
      - int
    doc: Length of the prefix sequence to ignore
    default: 0
    inputBinding:
      position: 101
      prefix: --ignored-sequence-prefix-length
  - id: input_forward
    type: string
    doc: Input forward FASTQ file
    inputBinding:
      position: 101
      prefix: --input-forward
  - id: input_reverse
    type: string
    doc: Input reverse FASTQ file
    inputBinding:
      position: 101
      prefix: --input-reverse
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers
    default: Depends on observed read length
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minimizer_count
    type:
      - 'null'
      - int
    doc: Number of minimizers to use
    default: Depends on observed read length
    inputBinding:
      position: 101
      prefix: --minimizer-count
  - id: minimizer_threshold
    type:
      - 'null'
      - int
    doc: Threshold for minimizers
    default: Depends on observed read length
    inputBinding:
      position: 101
      prefix: --minimizer-threshold
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort output
    inputBinding:
      position: 101
      prefix: --no-sort
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output
    inputBinding:
      position: 101
      prefix: --silent
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calib:0.3.4--hdcf5f25_5
stdout: calib.out
