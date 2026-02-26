cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges download
label: ibridges_download
doc: "Download a data object or collection from an iRODS server.\n\nTool homepage:
  https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: remote_path
    type: string
    doc: Path to remote iRODS location starting with 'irods:'.
    inputBinding:
      position: 1
  - id: local_path
    type:
      - 'null'
      - string
    doc: Local path to download the data object/collection to.
    inputBinding:
      position: 2
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform the download, but list the files to be updated.
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: metadata
    type:
      - 'null'
      - string
    doc: Path to the metadata file which will be created.
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
    doc: Overwrite the local file(s) if it exists.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: resource
    type:
      - 'null'
      - string
    doc: Name of the resource from which the data is to be downloaded.
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
stdout: ibridges_download.out
