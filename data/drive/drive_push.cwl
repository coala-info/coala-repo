cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_push
label: drive_push
doc: "Pushes files and directories to Google Drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: allow_hidden
    type:
      - 'null'
      - boolean
    doc: allows pushing of hidden paths
    inputBinding:
      position: 101
      prefix: --hidden
  - id: allow_mounted_paths
    type:
      - 'null'
      - boolean
    doc: allows pushing of mounted paths
    inputBinding:
      position: 101
      prefix: -m
  - id: coerced_mime
    type:
      - 'null'
      - string
    doc: the mimeType you are trying to coerce this file to be
    inputBinding:
      position: 101
      prefix: --coerced-mime
  - id: convert
    type:
      - 'null'
      - boolean
    doc: toggles conversion of the file to its appropriate Google Doc format
    inputBinding:
      position: 101
      prefix: --convert
  - id: depth
    type:
      - 'null'
      - int
    doc: max traversal depth
    inputBinding:
      position: 101
      prefix: --depth
  - id: destination
    type:
      - 'null'
      - string
    doc: specify the final destination of the contents of an operation
    inputBinding:
      position: 101
      prefix: --destination
  - id: encryption_password
    type:
      - 'null'
      - string
    doc: encryption password
    inputBinding:
      position: 101
      prefix: --encryption-password
  - id: exclude_ops
    type:
      - 'null'
      - string
    doc: exclude operations
    inputBinding:
      position: 101
      prefix: --exclude-ops
  - id: fix_clashes
    type:
      - 'null'
      - boolean
    doc: fix clashes by renaming or trashing files
    inputBinding:
      position: 101
      prefix: --fix-clashes
  - id: force
    type:
      - 'null'
      - boolean
    doc: forces a push even if no changes present
    inputBinding:
      position: 101
      prefix: --force
  - id: ignore_checksum
    type:
      - 'null'
      - boolean
    doc: 'avoids computation of checksums as a final check. Use cases may include:
      * when you are low on bandwidth e.g SSHFS. * Are on a low power device (default
      true)'
    inputBinding:
      position: 101
      prefix: --ignore-checksum
  - id: ignore_conflict
    type:
      - 'null'
      - boolean
    doc: turns off the conflict resolution safety
    inputBinding:
      position: 101
      prefix: --ignore-conflict
  - id: ignore_name_clashes
    type:
      - 'null'
      - boolean
    doc: ignore name clashes
    inputBinding:
      position: 101
      prefix: --ignore-name-clashes
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: prevents overwriting of old content
    inputBinding:
      position: 101
      prefix: --no-clobber
  - id: no_prompt
    type:
      - 'null'
      - boolean
    doc: shows no prompt before applying the push action
    inputBinding:
      position: 101
      prefix: --no-prompt
  - id: ocr
    type:
      - 'null'
      - boolean
    doc: if true, attempt OCR on gif, jpg, pdf and png uploads
    inputBinding:
      position: 101
      prefix: --ocr
  - id: piped
    type:
      - 'null'
      - boolean
    doc: get content in from standard input (stdin)
    inputBinding:
      position: 101
      prefix: --piped
  - id: push_only_directories
    type:
      - 'null'
      - boolean
    doc: push only directories
    inputBinding:
      position: 101
      prefix: --directories
  - id: push_only_files
    type:
      - 'null'
      - boolean
    doc: push only files
    inputBinding:
      position: 101
      prefix: --files
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: performs the push action recursively (default true)
    inputBinding:
      position: 101
      prefix: --recursive
  - id: retry_count
    type:
      - 'null'
      - int
    doc: max number of retries for exponential backoff
    inputBinding:
      position: 101
      prefix: --retry-count
  - id: skip_mime
    type:
      - 'null'
      - string
    doc: skip elements with mimeTypes derived from these extensions
    inputBinding:
      position: 101
      prefix: --skip-mime
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show step by step information verbosely
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_push.out
