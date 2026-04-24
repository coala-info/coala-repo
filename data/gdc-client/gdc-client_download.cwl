cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gdc-client
  - download
label: gdc-client_download
doc: "Download files from the GDC\n\nTool homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool"
inputs:
  - id: file_id
    type:
      type: array
      items: string
    doc: The GDC UUID of the file(s) to download
    inputBinding:
      position: 1
  - id: color_off
    type:
      - 'null'
      - boolean
    doc: Disable colored output
    inputBinding:
      position: 102
      prefix: --color_off
  - id: config
    type:
      - 'null'
      - File
    doc: Path to INI-type config file
    inputBinding:
      position: 102
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging. If a failure occurs, the program will stop.
    inputBinding:
      position: 102
      prefix: --debug
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Directory to download files to. Defaults to current directory
    inputBinding:
      position: 102
      prefix: --dir
  - id: http_chunk_size
    type:
      - 'null'
      - int
    doc: Size in bytes of standard HTTP block size.
    inputBinding:
      position: 102
      prefix: --http-chunk-size
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Download latest version of a file if it exists
    inputBinding:
      position: 102
      prefix: --latest
  - id: log_file
    type:
      - 'null'
      - File
    doc: Save logs to file. Amount logged affected by --debug
    inputBinding:
      position: 102
      prefix: --log-file
  - id: manifest
    type:
      - 'null'
      - File
    doc: GDC download manifest file
    inputBinding:
      position: 102
      prefix: --manifest
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of client connections.
    inputBinding:
      position: 102
      prefix: --n-processes
  - id: no_annotations
    type:
      - 'null'
      - boolean
    doc: Do not download annotations.
    inputBinding:
      position: 102
      prefix: --no-annotations
  - id: no_auto_retry
    type:
      - 'null'
      - boolean
    doc: Ask before retrying to download a file
    inputBinding:
      position: 102
      prefix: --no-auto-retry
  - id: no_file_md5sum
    type:
      - 'null'
      - boolean
    doc: Do not verify file md5sum after download
    inputBinding:
      position: 102
      prefix: --no-file-md5sum
  - id: no_related_files
    type:
      - 'null'
      - boolean
    doc: Do not download related files.
    inputBinding:
      position: 102
      prefix: --no-related-files
  - id: no_segment_md5sums
    type:
      - 'null'
      - boolean
    doc: Do not calculate inbound segment md5sums and/or do not verify md5sums 
      on restart
    inputBinding:
      position: 102
      prefix: --no-segment-md5sums
  - id: no_verify
    type:
      - 'null'
      - boolean
    doc: Perform insecure SSL connection and transfer
    inputBinding:
      position: 102
      prefix: --no-verify
  - id: retry_amount
    type:
      - 'null'
      - int
    doc: Number of times to retry a download
    inputBinding:
      position: 102
      prefix: --retry-amount
  - id: save_interval
    type:
      - 'null'
      - int
    doc: The number of chunks after which to flush state file. A lower save 
      interval will result in more frequent printout but lower performance.
    inputBinding:
      position: 102
      prefix: --save-interval
  - id: server
    type:
      - 'null'
      - string
    doc: The TCP server address server[:port]
    inputBinding:
      position: 102
      prefix: --server
  - id: token_file
    type:
      - 'null'
      - File
    doc: GDC API auth token file
    inputBinding:
      position: 102
      prefix: --token-file
  - id: wait_time
    type:
      - 'null'
      - int
    doc: Amount of seconds to wait before retrying
    inputBinding:
      position: 102
      prefix: --wait-time
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1
stdout: gdc-client_download.out
