cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gof3r
  - rm
label: s3gof3r_gof3r_rm
doc: "delete from S3\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
inputs:
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
    doc: 'version ID of the object version to delete'
    inputBinding:
      position: 1
      prefix: --versionId
  - id: path
    type: string
    doc: 'S3 object to delete (s3://bucket/key)'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: 'Standard output'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r_gof3r_rm.out
