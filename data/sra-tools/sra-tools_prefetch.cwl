cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefetch
label: sra-tools_prefetch
doc: Download SRA files and their dependencies
inputs:
  - id: input
    type:
      type: array
      items: string
    doc: SRA accession, URL, or SRA file to download
    inputBinding:
      position: 1
  - id: type
    type:
      - 'null'
      - string
    doc: Specify file type to download.
    inputBinding:
      position: 102
      prefix: --type
  - id: transport
    type:
      - 'null'
      - string
    doc: 'Transport: one of: fasp; http; both. (fasp only; http only; first try fasp
      (ascp), use http if cannot download using fasp).'
    inputBinding:
      position: 102
      prefix: --transport
  - id: location
    type:
      - 'null'
      - string
    doc: Location of data.
    inputBinding:
      position: 102
      prefix: --location
  - id: min_size
    type:
      - 'null'
      - string
    doc: Minimum file size to download in KB (inclusive).
    inputBinding:
      position: 102
      prefix: --min-size
  - id: max_size
    type:
      - 'null'
      - string
    doc: Maximum file size to download in KB (exclusive).
    inputBinding:
      position: 102
      prefix: --max-size
  - id: force
    type:
      - 'null'
      - string
    doc: 'Force object download: one of: no, yes, all, ALL.'
    inputBinding:
      position: 102
      prefix: --force
  - id: resume
    type:
      - 'null'
      - string
    doc: 'Resume partial downloads: one of: no, yes.'
    inputBinding:
      position: 102
      prefix: --resume
  - id: verify
    type:
      - 'null'
      - string
    doc: 'Verify after download: one of: no, yes.'
    inputBinding:
      position: 102
      prefix: --verify
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress.
    inputBinding:
      position: 102
      prefix: --progress
  - id: heartbeat
    type:
      - 'null'
      - int
    doc: 'Time period in minutes to display download progress. (0: no progress)'
    inputBinding:
      position: 102
      prefix: --heartbeat
  - id: eliminate_quals
    type:
      - 'null'
      - boolean
    doc: Download SRA Lite files with simplified base quality scores, or fail if
      not available.
    inputBinding:
      position: 102
      prefix: --eliminate-quals
  - id: check_all
    type:
      - 'null'
      - boolean
    doc: Double-check all refseqs.
    inputBinding:
      position: 102
      prefix: --check-all
  - id: check_rs
    type:
      - 'null'
      - string
    doc: 'Check for refseqs in downloaded files: one of: no, yes, smart.'
    inputBinding:
      position: 102
      prefix: --check-rs
  - id: list
    type:
      - 'null'
      - boolean
    doc: List the content of kart file.
    inputBinding:
      position: 102
      prefix: --list
  - id: numbered_list
    type:
      - 'null'
      - boolean
    doc: List the content of kart file with kart row numbers.
    inputBinding:
      position: 102
      prefix: --numbered-list
  - id: list_sizes
    type:
      - 'null'
      - boolean
    doc: List the content of kart file with target file sizes.
    inputBinding:
      position: 102
      prefix: --list-sizes
  - id: order
    type:
      - 'null'
      - string
    doc: 'Kart prefetch order when downloading kart: one of: kart, size.'
    inputBinding:
      position: 102
      prefix: --order
  - id: rows
    type:
      - 'null'
      - string
    doc: Kart rows to download (default all). Row list should be ordered.
    inputBinding:
      position: 102
      prefix: --rows
  - id: perm
    type: File
    doc: PATH to jwt cart file.
    inputBinding:
      position: 102
      prefix: --perm
  - id: ngc
    type:
      - 'null'
      - File
    doc: PATH to ngc file.
    inputBinding:
      position: 102
      prefix: --ngc
  - id: cart
    type:
      - 'null'
      - File
    doc: To read kart file.
    inputBinding:
      position: 102
      prefix: --cart
  - id: ascp_path
    type:
      - 'null'
      - string
    doc: Path to ascp program and private key file (aspera_tokenauth_id_rsa)
    inputBinding:
      position: 102
      prefix: --ascp-path
  - id: ascp_options
    type:
      - 'null'
      - string
    doc: Arbitrary options to pass to ascp command line.
    inputBinding:
      position: 102
      prefix: --ascp-options
  - id: output_directory
    type: string
    doc: Save files to DIRECTORY/
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
outputs:
  - id: output_output_directory
    type:
      - 'null'
      - Directory
    doc: Save files to DIRECTORY/
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/
