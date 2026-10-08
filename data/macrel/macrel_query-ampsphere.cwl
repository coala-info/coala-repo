cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macrel
  - query-ampsphere
label: macrel_query-ampsphere
doc: "Query peptide sequences against the AMPSphere database of antimicrobial peptides (web API or local database).\n\nTool homepage: https://github.com/BigDataBiology/macrel"
inputs:
  - id: fasta_file
    type: File
    doc: "path to the input FASTA file of peptide sequences to query"
    inputBinding:
      position: 102
      prefix: --fasta
  - id: output_dir
    type: string
    default: "macrel_out"
    doc: "path to the output directory (must not exist yet)"
    inputBinding:
      position: 102
      prefix: --output
  - id: query_mode
    type:
      - 'null'
      - string
    doc: "Query mode to use in the AMPSphere query (options: exact, mmseqs, hmmer; default: exact)"
    inputBinding:
      position: 102
      prefix: --query-mode
  - id: local
    type:
      - 'null'
      - boolean
    doc: "Use local AMPSphere database (downloaded into the cache directory) instead of the AMPSphere web API"
    inputBinding:
      position: 102
      prefix: --local
  - id: re_download_database
    type:
      - 'null'
      - boolean
    doc: "Download the AMPSphere database even if it already was downloaded before"
    inputBinding:
      position: 102
      prefix: --re-download-database
  - id: no_download_database
    type:
      - 'null'
      - boolean
    doc: "Do not download the AMPSphere database"
    inputBinding:
      position: 102
      prefix: --no-download-database
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: "Directory to use for caching AMPSphere data (an existing cache with the database)"
    inputBinding:
      position: 102
      prefix: --cache-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 102
      prefix: --threads
  - id: outtag
    type:
      - 'null'
      - string
    doc: "Set output tag (prefix of the output file names; default: macrel.out)"
    inputBinding:
      position: 102
      prefix: --tag
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite the output folder if it already exists"
    inputBinding:
      position: 102
      prefix: --force
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "Temporary directory to use (default: $TMPDIR in the environment or /tmp)"
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print debug information"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Print only errors"
    inputBinding:
      position: 102
      prefix: --quiet
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Path to the output logfile"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_append
    type:
      - 'null'
      - boolean
    doc: "If set, then the log file is appended to (default: overwrite existing file)"
    inputBinding:
      position: 102
      prefix: --log-append
outputs:
  - id: output
    type: Directory
    doc: "Macrel output directory"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
