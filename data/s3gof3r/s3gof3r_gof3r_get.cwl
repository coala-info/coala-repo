cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gof3r
  - get
label: s3gof3r_gof3r_get
doc: "get (download) object from S3\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
inputs:
  - id: key
    type: string
    doc: 'S3 object key'
    inputBinding:
      position: 1
      prefix: --key
  - id: bucket
    type: string
    doc: 'S3 bucket'
    inputBinding:
      position: 1
      prefix: --bucket
  - id: path
    type:
      - 'null'
      - string
    doc: 'Path to file. Defaults to standard output for streaming.'
    inputBinding:
      position: 1
      prefix: --path
  - id: no_ssl
    type:
      - 'null'
      - boolean
    doc: 'Do not use SSL for endpoint connection.'
    inputBinding:
      position: 1
      prefix: --no-ssl
  - id: no_md5
    type:
      - 'null'
      - boolean
    doc: 'Do not use md5 hash checking to ensure data integrity. By default, the md5 hash of is calculated concurrently during puts, stored at <bucket>.md5/<key>.md5, and verified on gets.'
    inputBinding:
      position: 1
      prefix: --no-md5
  - id: concurrency
    type:
      - 'null'
      - int
    doc: 'Concurrency of transfers (default: 10)'
    inputBinding:
      position: 1
      prefix: --concurrency
  - id: partsize
    type:
      - 'null'
      - int
    doc: 'Initial size of concurrent parts, in bytes (default: 20971520)'
    inputBinding:
      position: 1
      prefix: --partsize
  - id: endpoint
    type:
      - 'null'
      - string
    doc: 'Amazon S3 endpoint (default: s3.amazonaws.com)'
    inputBinding:
      position: 1
      prefix: --endpoint
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Enable debug logging.'
    inputBinding:
      position: 1
      prefix: --debug
  - id: version_id
    type:
      - 'null'
      - string
    doc: 'Version ID of the object. Incompatible with md5 check (use --no-md5).'
    inputBinding:
      position: 1
      prefix: --versionId
outputs:
  - id: stdout
    type: stdout
    doc: 'Standard output'
  - id: downloaded_file
    type:
      - 'null'
      - File
    doc: 'Downloaded object (when a path is given)'
    outputBinding:
      glob: $(inputs.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r_gof3r_get.out
