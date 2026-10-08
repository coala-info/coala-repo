cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kingfisher
  - get
label: kingfisher_get
doc: "Download data from ENA or SRA.\n\nTool homepage: https://github.com/wwood/kingfisher-download"
inputs:
  - id: allow_paid
    type:
      - 'null'
      - boolean
    doc: Allow downloading paid data
    inputBinding:
      position: 101
      prefix: --allow-paid
  - id: allow_paid_from_aws
    type:
      - 'null'
      - boolean
    doc: Allow downloading paid data from AWS
    inputBinding:
      position: 101
      prefix: --allow-paid-from-aws
  - id: allow_paid_from_gcp
    type:
      - 'null'
      - boolean
    doc: Allow downloading paid data from GCP
    inputBinding:
      position: 101
      prefix: --allow-paid-from-gcp
  - id: ascp_args
    type:
      - 'null'
      - string
    doc: Additional arguments to pass to ascp
    inputBinding:
      position: 101
      prefix: --ascp-args
  - id: ascp_ssh_key
    type:
      - 'null'
      - File
    doc: SSH key to use for ascp
    inputBinding:
      position: 101
      prefix: --ascp-ssh-key
  - id: aws_user_key_id
    type:
      - 'null'
      - string
    doc: AWS user key ID
    inputBinding:
      position: 101
      prefix: --aws-user-key-id
  - id: aws_user_key_secret
    type:
      - 'null'
      - string
    doc: AWS user key secret
    inputBinding:
      position: 101
      prefix: --aws-user-key-secret
  - id: bioprojects
    type:
      - 'null'
      - type: array
        items: string
    doc: Bioprojects to download
    inputBinding:
      position: 101
      prefix: -p
  - id: check_md5sums
    type:
      - 'null'
      - boolean
    doc: Check MD5 sums of downloaded files
    inputBinding:
      position: 101
      prefix: --check-md5sums
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: download_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for downloading
    inputBinding:
      position: 101
      prefix: --download-threads
  - id: extraction_threads
    type:
      - 'null'
      - int
    doc: Number of threads for extraction
    inputBinding:
      position: 101
      prefix: -t
  - id: output_format_possibilities
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Allowable output formats (sra, fastq, fastq.gz, fasta, fasta.gz). If 
      more than one is specified, downloaded data will be processed as little as
      possible [default: fastq fastq.gz].'
    inputBinding:
      position: 101
      prefix: --output-format-possibilities
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download even if files exist
    inputBinding:
      position: 101
      prefix: --force
  - id: gcp_project
    type:
      - 'null'
      - string
    doc: GCP project ID
    inputBinding:
      position: 101
      prefix: --gcp-project
  - id: gcp_user_key_file
    type:
      - 'null'
      - File
    doc: GCP user key file
    inputBinding:
      position: 101
      prefix: --gcp-user-key-file
  - id: guess_aws_location
    type:
      - 'null'
      - boolean
    doc: Guess AWS location
    inputBinding:
      position: 101
      prefix: --guess-aws-location
  - id: hide_download_progress
    type:
      - 'null'
      - boolean
    doc: Hide download progress bar
    inputBinding:
      position: 101
      prefix: --hide-download-progress
  - id: method
    type:
      type: array
      items: string
    doc: 'How to download the .sra file; each is tried in turn until one works: 
      aws-http, prefetch, aws-cp, gcp-cp, ena-ascp, ena-ftp [required].'
    inputBinding:
      position: 101
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - string
    doc: 'Output directory to write to [default: current working directory]'
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: prefetch_max_size
    type:
      - 'null'
      - int
    doc: Maximum size for prefetching
    inputBinding:
      position: 101
      prefix: --prefetch-max-size
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_identifiers
    type:
      - 'null'
      - type: array
        items: string
    doc: Run identifiers to download
    inputBinding:
      position: 101
      prefix: -r
  - id: run_identifiers_list
    type:
      - 'null'
      - File
    doc: File containing run identifiers to download
    inputBinding:
      position: 101
      prefix: --run-identifiers-list
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout instead of files
    inputBinding:
      position: 101
      prefix: --stdout
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: Do not sort downloaded files
    inputBinding:
      position: 101
      prefix: --unsorted
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (sequences when --stdout is set)
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Downloaded or extracted .sra, FASTQ or FASTA files.
    outputBinding:
      glob: |-
        ${
          var d = inputs.output_directory ? inputs.output_directory + "/" : "";
          return [d + "*.sra", d + "*.fastq", d + "*.fastq.gz", d + "*.fasta", d + "*.fasta.gz"];
        }
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
stdout: kingfisher_get.out
