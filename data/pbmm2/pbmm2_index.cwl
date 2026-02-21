cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbmm2
  - index
label: pbmm2_index
doc: "Index reference and store as .mmi file\n\nTool homepage: https://github.com/PacificBiosciences/pbmm2"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA, ReferenceSet XML
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28).
    default: -1
    inputBinding:
      position: 102
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    default: WARN
    inputBinding:
      position: 102
      prefix: --log-level
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size.
    default: -1
    inputBinding:
      position: 102
      prefix: -w
  - id: no_kmer_compression
    type:
      - 'null'
      - boolean
    doc: Disable homopolymer-compressed k-mer (compression is active for SUBREAD &
      UNROLLED presets).
    inputBinding:
      position: 102
      prefix: --no-kmer-compression
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Set alignment mode. Valid choices: (SUBREAD, CCS, ISOSEQ, UNROLLED).'
    default: CCS
    inputBinding:
      position: 102
      prefix: --preset
outputs:
  - id: output_index
    type: File
    doc: Output Reference Index
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbmm2:26.1.0--h9ee0642_0
