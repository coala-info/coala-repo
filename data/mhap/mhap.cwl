cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhap
label: mhap
doc: "MinHash Alignment Process (MHAP) for finding overlaps between long-read sequences
  using a MinHash indexing strategy.\n\nTool homepage: https://github.com/marbl/MHAP"
inputs:
  - id: directory_path
    type:
      - 'null'
      - Directory
    doc: Path to a directory containing input files for processing.
    inputBinding:
      position: 101
      prefix: -p
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Path to a k-mer filter file (e.g., produced by count-kmers).
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of the k-mers used for hashing.
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: no_self
    type:
      - 'null'
      - boolean
    doc: Do not compute self-overlaps between sequences in the same file.
    inputBinding:
      position: 101
      prefix: --no-self
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: Number of hashes to use in the MinHash sketch.
    inputBinding:
      position: 101
      prefix: --num-hashes
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: query_file
    type:
      - 'null'
      - File
    doc: Path to the query FASTA/FASTQ file.
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Path to the reference FASTA/FASTQ file.
    inputBinding:
      position: 101
      prefix: -r
  - id: spec_file
    type:
      - 'null'
      - File
    doc: Path to a configuration file containing MHAP settings.
    inputBinding:
      position: 101
      prefix: -s
  - id: store_full_id
    type:
      - 'null'
      - boolean
    doc: Store full string IDs instead of numerical indices.
    inputBinding:
      position: 101
      prefix: --store-full-id
  - id: threshold
    type:
      - 'null'
      - float
    doc: The threshold for the Jaccard score to accept an overlap.
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhap:2.1.3--0
stdout: mhap.out
