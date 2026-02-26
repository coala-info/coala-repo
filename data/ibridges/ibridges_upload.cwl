cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges_upload
label: ibridges_upload
doc: "Upload a data object or collection to an iRODS server.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: local_path
    type: string
    doc: Local path to upload the data object/collection from.
    inputBinding:
      position: 1
  - id: remote_path
    type:
      - 'null'
      - string
    doc: Path to remote iRODS location starting with 'irods:'.
    inputBinding:
      position: 2
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform the upload, but list the files to be updated.
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: metadata
    type:
      - 'null'
      - string
    doc: Path to the metadata json.
    inputBinding:
      position: 103
      prefix: --metadata
  - id: on_error
    type:
      - 'null'
      - string
    doc: When a transfer of a file fails, by default the whole transfer will 
      stop and print the error message(fail). By setting 'on-error' to 'warn', 
      those errors will be turned into warnings and the transfer continues with 
      the next file. Setting 'on-error' to 'skip' will omit any message and 
      simply proceed.
    inputBinding:
      position: 103
      prefix: --on-error
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the remote file(s) if it exists.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: resource
    type:
      - 'null'
      - string
    doc: Name of the resource to which the data is to be uploaded.
    inputBinding:
      position: 103
      prefix: --resource
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_upload.out
