cwlVersion: v1.2
class: CommandLineTool
baseCommand: dxua
label: dxua
doc: "Upload files to the platform.\n\nTool homepage: https://documentation.dnanexus.com/user/objects/uploading-and-downloading-files/batch/upload-agent"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: File(s) to upload
    inputBinding:
      position: 1
  - id: auth_token
    type:
      - 'null'
      - string
    doc: Specify the authentication token
    inputBinding:
      position: 102
      prefix: --auth-token
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: Size of chunks in which the file should be uploaded. Specify an integer
      size in bytes or append optional units (B, K, M, G). E.g., '50M' sets 
      chunk size to 50 megabytes.
    default: 75M
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: compress_threads
    type:
      - 'null'
      - int
    doc: Number of parallel compression threads
    default: 8
    inputBinding:
      position: 102
      prefix: --compress-threads
  - id: details
    type:
      - 'null'
      - string
    doc: JSON to store as details
    inputBinding:
      position: 102
      prefix: --details
  - id: do_not_compress
    type:
      - 'null'
      - boolean
    doc: Do not compress file(s) before upload
    inputBinding:
      position: 102
      prefix: --do-not-compress
  - id: do_not_resume
    type:
      - 'null'
      - boolean
    doc: Do not attempt to resume any incomplete uploads
    inputBinding:
      position: 102
      prefix: --do-not-resume
  - id: env
    type:
      - 'null'
      - boolean
    doc: Print environment information
    inputBinding:
      position: 102
      prefix: --env
  - id: folder
    type:
      - 'null'
      - string
    doc: Name of the destination folder
    default: /
    inputBinding:
      position: 102
      prefix: --folder
  - id: name
    type:
      - 'null'
      - string
    doc: 'Name of the remote file (Note: Extension .gz will be appended if the file
      is compressed before uploading)'
    inputBinding:
      position: 102
      prefix: --name
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Report upload progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: project
    type:
      - 'null'
      - string
    doc: Name or ID of the destination project
    inputBinding:
      position: 102
      prefix: --project
  - id: property
    type:
      - 'null'
      - type: array
        items: string
    doc: Key-value pair to add as a property; repeat as necessary, e.g. 
      "--property key1=val1 --property key2=val2"
    inputBinding:
      position: 102
      prefix: --property
  - id: read_from_stdin
    type:
      - 'null'
      - boolean
    doc: Read file content from stdin
    inputBinding:
      position: 102
      prefix: --read-from-stdin
  - id: read_threads
    type:
      - 'null'
      - int
    doc: Number of parallel disk read threads
    default: 2
    inputBinding:
      position: 102
      prefix: --read-threads
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively upload the directories
    inputBinding:
      position: 102
      prefix: --recursive
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Tag of the data object; repeat as necessary, e.g. "--tag tag1 --tag 
      tag2"
    inputBinding:
      position: 102
      prefix: --tag
  - id: test
    type:
      - 'null'
      - boolean
    doc: Test upload agent settings
    inputBinding:
      position: 102
      prefix: --test
  - id: throttle
    type:
      - 'null'
      - string
    doc: Limit maximum upload speed. Specify an integer to set speed in 
      bytes/second or append optional units (B, K, M, G). E.g., '3M' limits 
      upload speed to 3 megabytes/second. If not set, uploads are not throttled.
    inputBinding:
      position: 102
      prefix: --throttle
  - id: tries
    type:
      - 'null'
      - int
    doc: Number of tries to upload each chunk
    default: 3
    inputBinding:
      position: 102
      prefix: --tries
  - id: type
    type:
      - 'null'
      - type: array
        items: string
    doc: Type of the data object; repeat as necessary, e.g. "--type type1 --type
      type2"
    inputBinding:
      position: 102
      prefix: --type
  - id: upload_threads
    type:
      - 'null'
      - int
    doc: Number of parallel upload threads
    default: 8
    inputBinding:
      position: 102
      prefix: --upload-threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 102
      prefix: --verbose
  - id: visibility
    type:
      - 'null'
      - string
    doc: Use "--visibility hidden" to set the file's visibility as hidden.
    default: visible
    inputBinding:
      position: 102
      prefix: --visibility
  - id: wait_on_close
    type:
      - 'null'
      - boolean
    doc: Wait for file objects to be closed before exiting
    inputBinding:
      position: 102
      prefix: --wait-on-close
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxua:1.5.31--0
stdout: dxua.out
