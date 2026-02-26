cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi build
label: bigsi_build
doc: "Build a BIGSI index.\n\nTool homepage: https://github.com/Phelimb/BIGSI"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing index if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store the index
    inputBinding:
      position: 102
      prefix: --index-dir
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers to use
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: Number of hash functions to use
    default: 3
    inputBinding:
      position: 102
      prefix: --num-hashes
  - id: num_tables
    type:
      - 'null'
      - int
    doc: Number of hash tables to use
    default: 5
    inputBinding:
      position: 102
      prefix: --num-tables
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_build.out
