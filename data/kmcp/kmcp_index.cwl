cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - index
label: kmcp_index
doc: "Construct a database from k-mer files\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: alias
    type: ['null', string]
    doc: "Database alias/name (default: basename of --out-dir)"
    inputBinding:
      position: 1
      prefix: "--alias"
  - id: block_size
    type: ['null', int]
    doc: "Block size, better be multiple of 64 for large number of input files"
    inputBinding:
      position: 1
      prefix: "--block-size"
  - id: block_size1_kmers_t
    type: ['null', string]
    doc: "If k-mers of single .unik file exceeds this threshold, an individual index is created for this file. Supported units: K, M, G (default \"200M\")"
    inputBinding:
      position: 1
      prefix: "--block-size1-kmers-t"
  - id: block_size8_kmers_t
    type: ['null', string]
    doc: "If k-mers of single .unik file exceeds this threshold, block size is changed to 8. Supported units: K, M, G (default \"20M\")"
    inputBinding:
      position: 1
      prefix: "--block-size8-kmers-t"
  - id: block_sizex
    type: ['null', int]
    doc: "If k-mers of single .unik file exceeds --block-sizeX-kmers-t, block size is changed to this value (default 256)"
    inputBinding:
      position: 1
      prefix: "--block-sizeX"
  - id: block_sizex_kmers_t
    type: ['null', string]
    doc: "If k-mers of single .unik file exceeds this threshold, block size is changed to --block-sizeX. Supported units: K, M, G (default \"10M\")"
    inputBinding:
      position: 1
      prefix: "--block-sizeX-kmers-t"
  - id: dry_run
    type: ['null', boolean]
    doc: "Dry run, useful for adjusting parameters"
    inputBinding:
      position: 1
      prefix: "--dry-run"
  - id: false_positive_rate
    type: ['null', float]
    doc: "False positive rate of the bloom filters, range: (0, 1) (default 0.3)"
    inputBinding:
      position: 1
      prefix: "--false-positive-rate"
  - id: file_regexp
    type: ['null', string]
    doc: "Regular expression for matching files in -I/--in-dir, case ignored (default \".unik$\")"
    inputBinding:
      position: 1
      prefix: "--file-regexp"
  - id: force
    type: ['null', boolean]
    doc: "Overwrite existed output directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: in_dir
    type: Directory
    doc: "Directory containing .unik files (the output of kmcp compute, with its _info.txt). It is staged in the working directory because _info.txt lists the files relative to it"
    inputBinding:
      position: 1
      prefix: --in-dir
      valueFrom: $(self.basename)
  - id: max_open_files
    type: ['null', int]
    doc: "Maximum number of opened files, please use a small value for hard disk drive storage (default 256)"
    inputBinding:
      position: 1
      prefix: "--max-open-files"
  - id: num_hash
    type: ['null', int]
    doc: "Number of hash functions in bloom filters (default 1)"
    inputBinding:
      position: 1
      prefix: "--num-hash"
  - id: out_dir
    type: string
    doc: "Output directory (the kmcp database)"
    inputBinding:
      position: 1
      prefix: "--out-dir"
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: db_dir
    type: Directory
    doc: "The kmcp database directory"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
      - $(inputs.in_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_index.out
