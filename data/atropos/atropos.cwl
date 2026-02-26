cwlVersion: v1.2
class: CommandLineTool
baseCommand: atropos
label: atropos
doc: "Trim adapters from high-throughput sequencing data.\n\nTool homepage: https://github.com/jdidion/atropos"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ file (or '-' for stdin).
    inputBinding:
      position: 1
  - id: adapter_string
    type:
      - 'null'
      - string
    doc: Comma-separated list of adapter sequences.
    inputBinding:
      position: 102
      prefix: --adapter-string
  - id: adapters
    type:
      - 'null'
      - File
    doc: File containing adapter sequences (one per line).
    inputBinding:
      position: 102
      prefix: --adapters
  - id: disable_pipelining
    type:
      - 'null'
      - boolean
    doc: Disable pipelining for debugging.
    inputBinding:
      position: 102
      prefix: --disable-pipelining
  - id: discard_all
    type:
      - 'null'
      - boolean
    doc: Discard all reads.
    inputBinding:
      position: 102
      prefix: --discard-all
  - id: discard_redundant
    type:
      - 'null'
      - boolean
    doc: Discard reads that were found to be redundant.
    inputBinding:
      position: 102
      prefix: --discard-redundant
  - id: discard_untrimmed
    type:
      - 'null'
      - boolean
    doc: Discard reads that were not trimmed.
    inputBinding:
      position: 102
      prefix: --discard-untrimmed
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Maximum allowed error rate for adapter matching.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: format
    type:
      - 'null'
      - string
    doc: Input file format (fastq or fasta).
    default: fastq
    inputBinding:
      position: 102
      prefix: --format
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file for statistics.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: match_adapter_wildcards
    type:
      - 'null'
      - boolean
    doc: Match wildcards in reads to adapter sequences.
    inputBinding:
      position: 102
      prefix: --match-adapter-wildcards
  - id: match_read_wildcards
    type:
      - 'null'
      - boolean
    doc: Match wildcards in adapter sequences to reads.
    inputBinding:
      position: 102
      prefix: --match-read-wildcards
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum length of reads to keep.
    default: 0
    inputBinding:
      position: 102
      prefix: --minimum-length
  - id: next_seq_id
    type:
      - 'null'
      - boolean
    doc: Prepend '>>' to the sequence ID of reads that have been trimmed.
    inputBinding:
      position: 102
      prefix: --next-seq-id
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Do not trim adapters, only report statistics.
    inputBinding:
      position: 102
      prefix: --no-trim
  - id: overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap length for adapter matching.
    inputBinding:
      position: 102
      prefix: --overlap
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold for trimming.
    default: 0
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress indicators.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: save_all
    type:
      - 'null'
      - boolean
    doc: Save all reads (trimmed, untrimmed, redundant) to separate files.
    inputBinding:
      position: 102
      prefix: --save-all
  - id: save_redundant
    type:
      - 'null'
      - boolean
    doc: Save redundant reads to a separate file.
    inputBinding:
      position: 102
      prefix: --save-redundant
  - id: save_trimmed
    type:
      - 'null'
      - boolean
    doc: Save trimmed reads to a separate file.
    inputBinding:
      position: 102
      prefix: --save-trimmed
  - id: save_untrimmed
    type:
      - 'null'
      - boolean
    doc: Save untrimmed reads to a separate file.
    inputBinding:
      position: 102
      prefix: --save-untrimmed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: times
    type:
      - 'null'
      - int
    doc: Number of times to trim adapters.
    default: 1
    inputBinding:
      position: 102
      prefix: --times
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTQ file (or '-' for stdout).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atropos:1.1.32--py312h0fa9677_4
