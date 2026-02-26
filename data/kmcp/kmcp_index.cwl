cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp index
label: kmcp_index
doc: "Construct a database from k-mer files\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: alias
    type:
      - 'null'
      - string
    doc: "Database alias/name. (default: basename of --out-dir). You can\n       \
      \                              also manually edit it in info file: ${outdir}/__db.yml."
    inputBinding:
      position: 101
      prefix: --alias
  - id: block_size
    type:
      - 'null'
      - int
    doc: "Block size, better be multiple of 64 for large number of input\n       \
      \                              files. (default: min(#.files/#theads, 8))"
    inputBinding:
      position: 101
      prefix: --block-size
  - id: block_size1_kmers_t
    type:
      - 'null'
      - string
    doc: "If k-mers of single .unik file exceeds this threshold, an\n            \
      \                         individual index is created for this file. Supported
      units: K, M,\n                                     G."
    default: 200M
    inputBinding:
      position: 101
      prefix: --block-size1-kmers-t
  - id: block_size8_kmers_t
    type:
      - 'null'
      - string
    doc: "If k-mers of single .unik file exceeds this threshold, block\n         \
      \                            size is changed to 8. Supported units: K, M, G."
    default: 20M
    inputBinding:
      position: 101
      prefix: --block-size8-kmers-t
  - id: block_sizeX
    type:
      - 'null'
      - int
    doc: "If k-mers of single .unik file exceeds --block-sizeX-kmers-t,\n        \
      \                             block size is changed to this value."
    default: 256
    inputBinding:
      position: 101
      prefix: --block-sizeX
  - id: block_sizeX_kmers_t
    type:
      - 'null'
      - string
    doc: "If k-mers of single .unik file exceeds this threshold, block\n         \
      \                            size is changed to --block-sizeX. Supported units:
      K, M, G."
    default: 10M
    inputBinding:
      position: 101
      prefix: --block-sizeX-kmers-t
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run, useful for adjusting parameters (highly recommended).
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: 'False positive rate of the bloom filters, range: (0, 1).'
    default: 0.3
    inputBinding:
      position: 101
      prefix: --false-positive-rate
  - id: file_regexp
    type:
      - 'null'
      - string
    doc: "Regular expression for matching files in -I/--in-dir, case\n           \
      \                          ignored."
    default: .unik$
    inputBinding:
      position: 101
      prefix: --file-regexp
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existed output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: in_dir
    type: Directory
    doc: Directory containing .unik files. Directory symlinks are followed.
    inputBinding:
      position: 101
      prefix: --in-dir
  - id: infile_list
    type:
      - 'null'
      - type: array
        items: File
    doc: "File of input files list (one file per line). If given, they are\n     \
      \                        appended to files from CLI arguments."
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    inputBinding:
      position: 101
      prefix: --log
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: "Maximum number of opened files, please use a small value for\n         \
      \                            hard disk drive storage."
    default: 256
    inputBinding:
      position: 101
      prefix: --max-open-files
  - id: num_hash
    type:
      - 'null'
      - int
    doc: Number of hash functions in bloom filters.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-hash
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not print any verbose information. But you can write them to file\n \
      \                            with --log."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: 'Output directory. (default: ${indir}.kmcp-db)'
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
