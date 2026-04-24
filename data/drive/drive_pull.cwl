cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_pull
label: drive_pull
doc: "Pulls files and directories from Google Drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: all the starred files
    inputBinding:
      position: 101
      prefix: --all
  - id: decryption_password
    type:
      - 'null'
      - string
    doc: decryption password
    inputBinding:
      position: 101
      prefix: --decryption-password
  - id: depth
    type:
      - 'null'
      - int
    doc: max traversal depth
    inputBinding:
      position: 101
      prefix: --depth
  - id: desktop_links
    type:
      - 'null'
      - boolean
    doc: allows docs + sheets to be pulled as .desktop files or URL linked files
    inputBinding:
      position: 101
      prefix: --desktop-links
  - id: directories
    type:
      - 'null'
      - boolean
    doc: pull only directories
    inputBinding:
      position: 101
      prefix: --directories
  - id: exclude_ops
    type:
      - 'null'
      - string
    doc: exclude operations
    inputBinding:
      position: 101
      prefix: --exclude-ops
  - id: explicitly_export
    type:
      - 'null'
      - boolean
    doc: explicitly pull exports
    inputBinding:
      position: 101
      prefix: --explicitly-export
  - id: export
    type:
      - 'null'
      - string
    doc: comma separated list of formats to export your docs + sheets files
    inputBinding:
      position: 101
      prefix: --export
  - id: exports_dir
    type:
      - 'null'
      - Directory
    doc: directory to place exports
    inputBinding:
      position: 101
      prefix: --exports-dir
  - id: files
    type:
      - 'null'
      - boolean
    doc: pull only files
    inputBinding:
      position: 101
      prefix: --files
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
    doc: forces a pull even if no changes present
    inputBinding:
      position: 101
      prefix: --force
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows pulling of hidden paths
    inputBinding:
      position: 101
      prefix: --hidden
  - id: id
    type:
      - 'null'
      - boolean
    doc: pull by id instead of path
    inputBinding:
      position: 101
      prefix: --id
  - id: ignore_checksum
    type:
      - 'null'
      - boolean
    doc: 'avoids computation of checksums as a final check. Use cases may include:
      * when you are low on bandwidth e.g SSHFS. * Are on a low power device'
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
  - id: matches
    type:
      - 'null'
      - boolean
    doc: search by prefix
    inputBinding:
      position: 101
      prefix: --matches
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
    doc: shows no prompt before applying the pull action
    inputBinding:
      position: 101
      prefix: --no-prompt
  - id: piped
    type:
      - 'null'
      - boolean
    doc: get content in from standard input (stdin)
    inputBinding:
      position: 101
      prefix: --piped
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
    doc: performs the pull action recursively
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
  - id: same_exports_dir
    type:
      - 'null'
      - boolean
    doc: exports are put in the same directory
    inputBinding:
      position: 101
      prefix: --same-exports-dir
  - id: skip_mime
    type:
      - 'null'
      - string
    doc: skip elements with mimeTypes derived from these extensions
    inputBinding:
      position: 101
      prefix: --skip-mime
  - id: starred
    type:
      - 'null'
      - boolean
    doc: operate only on starred files
    inputBinding:
      position: 101
      prefix: --starred
  - id: trashed
    type:
      - 'null'
      - boolean
    doc: pull content in the trash
    inputBinding:
      position: 101
      prefix: --trashed
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
stdout: drive_pull.out
