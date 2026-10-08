cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - prepare
  - chunkify
label: gappa_prepare_chunkify
doc: "Chunkify a set of fasta files and create abundance maps.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: fasta_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --fasta-path
  - id: chunk_size
    type: ['null', int]
    doc: "Number of sequences per chunk file. (Default: 50000)"
    inputBinding:
      position: 2
      prefix: --chunk-size
  - id: min_abundance
    type: ['null', int]
    doc: "Minimum abundance of a single sequence. Sequences below are filtered out. (Default: 1)"
    inputBinding:
      position: 3
      prefix: --min-abundance
  - id: hash_function
    type:
      - 'null'
      - type: enum
        symbols: [SHA1, SHA256, MD5]
    doc: "Hash function for re-naming and identifying sequences. (Default: SHA1)"
    inputBinding:
      position: 4
      prefix: --hash-function
  - id: chunks_out_dir
    type: ['null', string]
    doc: "Directory to write output chunks files to. (Default: .)"
    default: "chunks"
    inputBinding:
      position: 5
      prefix: --chunks-out-dir
  - id: chunks_file_prefix
    type: ['null', string]
    doc: "File prefix for chunks files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 6
      prefix: --chunks-file-prefix
  - id: chunks_file_suffix
    type: ['null', string]
    doc: "File suffix for chunks files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 7
      prefix: --chunks-file-suffix
  - id: abundances_out_dir
    type: ['null', string]
    doc: "Directory to write output abundances files to. (Default: .)"
    default: "abundances"
    inputBinding:
      position: 8
      prefix: --abundances-out-dir
  - id: abundances_file_prefix
    type: ['null', string]
    doc: "File prefix for abundances files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 9
      prefix: --abundances-file-prefix
  - id: abundances_file_suffix
    type: ['null', string]
    doc: "File suffix for abundances files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 10
      prefix: --abundances-file-suffix
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 11
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 12
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 13
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 14
      prefix: --log-file
outputs:
  - id: chunks_dir
    type: Directory
    doc: "Output directory (--chunks-out-dir)."
    outputBinding:
      glob: "$(inputs.chunks_out_dir)"
  - id: abundances_dir
    type: Directory
    doc: "Output directory (--abundances-out-dir)."
    outputBinding:
      glob: "$(inputs.abundances_out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
