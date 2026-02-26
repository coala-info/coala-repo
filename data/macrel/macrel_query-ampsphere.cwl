cwlVersion: v1.2
class: CommandLineTool
baseCommand: macrel
label: macrel_query-ampsphere
doc: "macrel v1.6.0\n\nTool homepage: https://github.com/BigDataBiology/macrel"
inputs:
  - id: command
    type: string
    doc: Macrel command to execute (see documentation)
    inputBinding:
      position: 1
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for caching AMPSphere data
    inputBinding:
      position: 102
      prefix: --cache-dir
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Whether to pre-cluster the smORFs (at 100% identity) to avoid repeats
    inputBinding:
      position: 102
      prefix: --cluster
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: path to the input FASTA file. This is used in both the peptides command
      (where the file is expected to contain short amino-acid sequences) and in 
      the contigs command (where the file is expected to contain longer 
      nucleotide contigs)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation
    inputBinding:
      position: 102
      prefix: --force
  - id: keep_fasta_headers
    type:
      - 'null'
      - boolean
    doc: Keep complete FASTA headers [get-smorfs command]
    inputBinding:
      position: 102
      prefix: --keep-fasta-headers
  - id: keep_negatives
    type:
      - 'null'
      - boolean
    doc: Whether to keep non-AMPs in the output
    inputBinding:
      position: 102
      prefix: --keep-negatives
  - id: local
    type:
      - 'null'
      - boolean
    doc: Use local AMPSphere database
    inputBinding:
      position: 102
      prefix: --local
  - id: log_append
    type:
      - 'null'
      - boolean
    doc: 'If set, then the log file is appended to (default: overwrite existing file)'
    inputBinding:
      position: 102
      prefix: --log-append
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to the output logfile
    inputBinding:
      position: 102
      prefix: --log-file
  - id: mem
    type:
      - 'null'
      - string
    doc: Memory limit
    inputBinding:
      position: 102
      prefix: --mem
  - id: no_download_database
    type:
      - 'null'
      - boolean
    doc: Do not download the AMPSphere database
    inputBinding:
      position: 102
      prefix: --no-download-database
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: path to the output directory
    inputBinding:
      position: 102
      prefix: --output
  - id: outtag
    type:
      - 'null'
      - string
    doc: Set output tag
    inputBinding:
      position: 102
      prefix: --tag
  - id: query_mode
    type:
      - 'null'
      - string
    doc: 'Query mode to use in the AMPSphere query (options: exact, mmseqs, hhm)'
    inputBinding:
      position: 102
      prefix: --query-mode
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Print only errors
    inputBinding:
      position: 102
      prefix: -q
  - id: re_download_database
    type:
      - 'null'
      - boolean
    doc: Download the AMPSphere database even if it already was downloaded 
      before
    inputBinding:
      position: 102
      prefix: --re-download-database
  - id: reads1
    type:
      - 'null'
      - File
    doc: Path to the first read file
    inputBinding:
      position: 102
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - File
    doc: Path to the second read file
    inputBinding:
      position: 102
      prefix: --reads2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: 'Temporary directory to use (default: $TMPDIR in the environment or /tmp)'
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug information
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: path to the output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
