cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - hash
label: google-cloud-sdk_gsutil_hash
doc: "Calculate file hashes (CRC32C and MD5) of local files.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: crc32c
    type:
      - 'null'
      - boolean
    doc: "Calculate a CRC32c hash for the file."
    inputBinding:
      position: 1
      prefix: -c
  - id: hex
    type:
      - 'null'
      - boolean
    doc: "Output hashes in hex format. By default, gsutil uses base64."
    inputBinding:
      position: 1
      prefix: -h
  - id: md5
    type:
      - 'null'
      - boolean
    doc: "Calculate a MD5 hash for the file."
    inputBinding:
      position: 1
      prefix: -m
  - id: filenames
    type:
      type: array
      items: File
    doc: "Local files to hash."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil_hash.out
