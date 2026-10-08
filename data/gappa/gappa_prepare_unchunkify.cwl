cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - prepare
  - unchunkify
label: gappa_prepare_unchunkify
doc: "Unchunkify a set of jplace files using abundance map files and create per-sample jplace files.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: abundances_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of abundances files or directories to process. For directories, only files with the extension `.json[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --abundances-path
  - id: jplace_path
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: "List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed. (Excludes: --chunk-list-file --chunk-file-expression)"
    inputBinding:
      position: 2
      prefix: --jplace-path
  - id: sequence_path
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: "List of sequence files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn|phylip|phy)[.gz]` are processed."
    inputBinding:
      position: 3
      prefix: --sequence-path
  - id: chunk_list_file
    type: ['null', File]
    doc: "If provided, needs to contain a list of chunk file paths in the numerical order that was produced by the chunkify command. (Excludes: --jplace-path --chunk-file-expression)"
    inputBinding:
      position: 4
      prefix: --chunk-list-file
  - id: chunk_file_expression
    type: ['null', string]
    doc: "If provided, the expression is used to load jplace files by replacing any '@' character with the chunk number. (Excludes: --jplace-path --chunk-list-file)"
    inputBinding:
      position: 5
      prefix: --chunk-file-expression
  - id: chunk_files
    type: ['null', {type: array, items: File}]
    doc: "Chunk jplace files named in --chunk-list-file or matched by --chunk-file-expression. They are staged in the working directory so that these names resolve."
  - id: jplace_cache_size
    type: ['null', int]
    doc: "Cache size to determine how many jplace files are kept in memory. Default (0) means all. Use this if the command runs out of memory. It however comes at the cost of longer runtime. (Default: 0)"
    inputBinding:
      position: 6
      prefix: --jplace-cache-size
  - id: hash_function
    type:
      - 'null'
      - type: enum
        symbols: [SHA1, SHA256, MD5]
    doc: "Hash function that was used for re-naming and identifying sequences in the chunkify command. (Default: SHA1)"
    inputBinding:
      position: 7
      prefix: --hash-function
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 8
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 9
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 10
      prefix: --file-suffix
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
  - id: output_dir
    type: Directory
    doc: "Output directory (--out-dir)."
    outputBinding:
      glob: "$(inputs.out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.chunk_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
