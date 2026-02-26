cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges sync
label: ibridges_sync
doc: "Synchronize files/directories between local and remote.\n\nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs:
  - id: source
    type: string
    doc: Source path to synchronize from (collection on irods server or local 
      directory).
    inputBinding:
      position: 1
  - id: destination
    type: string
    doc: Destination path to synchronize to (collection on irods server or local
      directory).
    inputBinding:
      position: 2
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform the synchronization, but list the files to be updated.
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to the metadata json file.
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges_sync.out
