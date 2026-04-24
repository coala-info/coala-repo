cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefetch
label: sra-tools_prefetch
doc: "Download SRA files and their dependencies\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs:
  - id: sra_accession
    type:
      type: array
      items: string
    doc: SRA accession to download
    inputBinding:
      position: 1
  - id: sra_file
    type:
      type: array
      items: File
    doc: SRA file to check for missed dependencies
    inputBinding:
      position: 2
  - id: url
    type:
      type: array
      items: string
    doc: URL to download
    inputBinding:
      position: 3
  - id: ascp_options
    type:
      - 'null'
      - string
    doc: Arbitrary options to pass to ascp command line
    inputBinding:
      position: 104
      prefix: --ascp-options
  - id: ascp_path
    type:
      - 'null'
      - string
    doc: Path to ascp program and private key file (asperaweb_id_dsa.putty)
    inputBinding:
      position: 104
      prefix: --ascp-path
  - id: cart_file
    type:
      - 'null'
      - File
    doc: To read kart file
    inputBinding:
      position: 104
      prefix: --cart
  - id: check_all
    type:
      - 'null'
      - boolean
    doc: Double-check all refseqs
    inputBinding:
      position: 104
      prefix: --check-all
  - id: check_rs
    type:
      - 'null'
      - string
    doc: 'Check for refseqs in downloaded files: one of: no, yes, smart'
    inputBinding:
      position: 104
      prefix: --check-rs
  - id: eliminate_quals
    type:
      - 'null'
      - boolean
    doc: Download SRA Lite files with simplified base quality scores, or fail if
      not available
    inputBinding:
      position: 104
      prefix: --eliminate-quals
  - id: file_type
    type:
      - 'null'
      - string
    doc: Specify file type to download
    inputBinding:
      position: 104
      prefix: --type
  - id: force
    type:
      - 'null'
      - string
    doc: 'Force object download: one of: no, yes, all, ALL'
    inputBinding:
      position: 104
      prefix: --force
  - id: heartbeat
    type:
      - 'null'
      - int
    doc: Time period in minutes to display download progress
    inputBinding:
      position: 104
      prefix: --heartbeat
  - id: jwt_cart_file
    type:
      - 'null'
      - File
    doc: PATH to jwt cart file
    inputBinding:
      position: 104
      prefix: --perm
  - id: list_kart
    type:
      - 'null'
      - boolean
    doc: List the content of kart file
    inputBinding:
      position: 104
      prefix: --list
  - id: list_sizes
    type:
      - 'null'
      - boolean
    doc: List the content of kart file with target file sizes
    inputBinding:
      position: 104
      prefix: --list-sizes
  - id: location
    type:
      - 'null'
      - string
    doc: Location of data
    inputBinding:
      position: 104
      prefix: --location
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string
    inputBinding:
      position: 104
      prefix: --log-level
  - id: max_size
    type:
      - 'null'
      - string
    doc: Maximum file size to download in KB (exclusive)
    inputBinding:
      position: 104
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum file size to download in KB (inclusive)
    inputBinding:
      position: 104
      prefix: --min-size
  - id: ngc_file
    type:
      - 'null'
      - File
    doc: PATH to ngc file
    inputBinding:
      position: 104
      prefix: --ngc
  - id: numbered_list
    type:
      - 'null'
      - boolean
    doc: List the content of kart file with kart row numbers
    inputBinding:
      position: 104
      prefix: --numbered-list
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file
    inputBinding:
      position: 104
      prefix: --option-file
  - id: order
    type:
      - 'null'
      - string
    doc: 'Kart prefetch order when downloading kart: one of: kart, size'
    inputBinding:
      position: 104
      prefix: --order
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress
    inputBinding:
      position: 104
      prefix: --progress
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program
    inputBinding:
      position: 104
      prefix: --quiet
  - id: resume
    type:
      - 'null'
      - string
    doc: 'Resume partial downloads: one of: no, yes'
    inputBinding:
      position: 104
      prefix: --resume
  - id: rows
    type:
      - 'null'
      - string
    doc: Kart rows to download (default all)
    inputBinding:
      position: 104
      prefix: --rows
  - id: transport
    type:
      - 'null'
      - string
    doc: 'Transport: one of: fasp; http; both'
    inputBinding:
      position: 104
      prefix: --transport
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of the program status messages
    inputBinding:
      position: 104
      prefix: --verbose
  - id: verify
    type:
      - 'null'
      - string
    doc: 'Verify after download: one of: no, yes'
    inputBinding:
      position: 104
      prefix: --verify
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write file to FILE when downloading single file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Save files to DIRECTORY/
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
