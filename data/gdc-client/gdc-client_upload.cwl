cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdc-client upload
label: gdc-client_upload
doc: "Upload files to the GDC.\n\nTool homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool"
inputs:
  - id: file_id
    type:
      type: array
      items: string
    doc: The GDC UUID of the file(s) to upload
    inputBinding:
      position: 1
  - id: abort
    type:
      - 'null'
      - boolean
    doc: Abort previous multipart upload
    inputBinding:
      position: 102
      prefix: --abort
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
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete an uploaded file
    inputBinding:
      position: 102
      prefix: --delete
  - id: disable_multipart
    type:
      - 'null'
      - boolean
    doc: Disable multipart upload
    inputBinding:
      position: 102
      prefix: --disable-multipart
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: Allow connections to server without certs
    inputBinding:
      position: 102
      prefix: --insecure
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
    doc: Manifest which describes files to be uploaded
    inputBinding:
      position: 102
      prefix: --manifest
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of client connections
    inputBinding:
      position: 102
      prefix: --n-processes
  - id: part_size
    type:
      - 'null'
      - int
    doc: DEPRECATED in favor of [--upload-part-size]
    inputBinding:
      position: 102
      prefix: --part-size
  - id: path
    type:
      - 'null'
      - Directory
    doc: directory path to find file
    inputBinding:
      position: 102
      prefix: --path
  - id: project_id
    type:
      - 'null'
      - string
    doc: The project ID that owns the file
    inputBinding:
      position: 102
      prefix: --project-id
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume previous multipart upload
    inputBinding:
      position: 102
      prefix: --resume
  - id: server
    type:
      - 'null'
      - string
    doc: GDC API server address
    inputBinding:
      position: 102
      prefix: --server
  - id: token_file
    type: File
    doc: GDC API auth token file
    inputBinding:
      position: 102
      prefix: --token-file
  - id: upload_id
    type:
      - 'null'
      - string
    doc: Multipart upload id
    inputBinding:
      position: 102
      prefix: --upload-id
  - id: upload_part_size
    type:
      - 'null'
      - int
    doc: Part size for multipart upload
    inputBinding:
      position: 102
      prefix: --upload-part-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1
stdout: gdc-client_upload.out
