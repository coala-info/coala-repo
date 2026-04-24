cwlVersion: v1.2
class: CommandLineTool
baseCommand: kfilt filter
label: kfilt_filter
doc: "Filter FASTA/FASTQ reads using hybrid index with Bloom filter quick rejection.\n\
  \nTool homepage: https://github.com/davidebolo1993/kfilt"
inputs:
  - id: both_match
    type:
      - 'null'
      - boolean
    doc: For pairs, require BOTH reads meet threshold
    inputBinding:
      position: 101
      prefix: --both-match
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output with gzip
    inputBinding:
      position: 101
      prefix: --compress
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Gzip compression level (1-9)
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: hamming_dist
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance
    inputBinding:
      position: 101
      prefix: --hamming-dist
  - id: index
    type:
      - 'null'
      - string
    doc: Index file
    inputBinding:
      position: 101
      prefix: --index
  - id: input1
    type:
      - 'null'
      - File
    doc: Input FASTA/FASTQ R1 or single-end
    inputBinding:
      position: 101
      prefix: --input1
  - id: input2
    type:
      - 'null'
      - File
    doc: Input FASTA/FASTQ R2 for paired-end
    inputBinding:
      position: 101
      prefix: --input2
  - id: interleaved
    type:
      - 'null'
      - File
    doc: Interleaved FASTA/FASTQ (mixed paired/single)
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: min_matches
    type:
      - 'null'
      - int
    doc: Minimum matching k-mers required
    inputBinding:
      position: 101
      prefix: --min-matches
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: fasta or fastq'
    inputBinding:
      position: 101
      prefix: --output-format
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - File
    doc: Verbose per-read output file (optional)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kfilt:0.1.1--he881be0_0
