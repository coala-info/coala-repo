cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gof3r
  - put
label: s3gof3r_gof3r_put
doc: "put (upload) data to S3 object\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
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
      - File
    doc: 'Path to file. Defaults to standard input for streaming.'
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
  - id: header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --header
    doc: 'HTTP headers. May be used to set custom metadata, server-side encryption etc.'
    inputBinding:
      position: 1
  - id: acl
    type:
      - 'null'
      - string
    doc: 'canned acl to apply to the object'
    inputBinding:
      position: 1
      prefix: --acl
outputs:
  - id: stdout
    type: stdout
    doc: 'Standard output'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r_gof3r_put.out
