cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimadap
label: trimadap
doc: "Trim adapter sequences from FASTQ files.\n\nTool homepage: https://github.com/lh3/trimadap"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file (gzipped or uncompressed).
    inputBinding:
      position: 1
  - id: adapter_sequence
    type:
      - 'null'
      - string
    doc: Adapter sequence to trim (if not provided in a file).
    inputBinding:
      position: 102
      prefix: --adapter-sequence
  - id: adapters
    type:
      - 'null'
      - File
    doc: FASTA file containing adapter sequences.
    inputBinding:
      position: 102
      prefix: --adapters
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Maximum allowed error rate for adapter matching.
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum length of reads to keep after trimming.
    inputBinding:
      position: 102
      prefix: --minimum-length
  - id: overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap required to consider a read as containing an adapter.
    inputBinding:
      position: 102
      prefix: --overlap
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Phred quality score threshold for trimming.
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file (gzipped or uncompressed).
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimadap:r9--0
