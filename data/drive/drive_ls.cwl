cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_ls
label: drive_ls
doc: "List files and directories in Google Drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: depth
    type:
      - 'null'
      - int
    doc: maximum recursion depth
    default: 1
    inputBinding:
      position: 101
      prefix: -depth
  - id: exact_owner
    type:
      - 'null'
      - string
    doc: elements with the exact owner
    inputBinding:
      position: 101
      prefix: -exact-owner
  - id: exact_title
    type:
      - 'null'
      - string
    doc: get elements with the exact titles
    inputBinding:
      position: 101
      prefix: -exact-title
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: list all paths even hidden ones
    inputBinding:
      position: 101
      prefix: -hidden
  - id: list_by_id
    type:
      - 'null'
      - boolean
    doc: list by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: list_by_prefix
    type:
      - 'null'
      - boolean
    doc: list by prefix
    inputBinding:
      position: 101
      prefix: -matches
  - id: list_directories
    type:
      - 'null'
      - boolean
    doc: list all directories
    inputBinding:
      position: 101
      prefix: -directories
  - id: list_files
    type:
      - 'null'
      - boolean
    doc: list only files
    inputBinding:
      position: 101
      prefix: -files
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: long listing of contents
    inputBinding:
      position: 101
      prefix: -long
  - id: match_mime
    type:
      - 'null'
      - string
    doc: get elements with the exact mimeTypes derived from extensions
    inputBinding:
      position: 101
      prefix: -match-mime
  - id: match_owner
    type:
      - 'null'
      - string
    doc: elements with matching owners
    inputBinding:
      position: 101
      prefix: -match-owner
  - id: no_prompt
    type:
      - 'null'
      - boolean
    doc: shows no prompt before pagination
    inputBinding:
      position: 101
      prefix: -no-prompt
  - id: pagesize
    type:
      - 'null'
      - int
    doc: number of results per pagination
    default: 100
    inputBinding:
      position: 101
      prefix: -pagesize
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursively list subdirectories
    inputBinding:
      position: 101
      prefix: -recursive
  - id: shared
    type:
      - 'null'
      - boolean
    doc: show files that are shared with me
    inputBinding:
      position: 101
      prefix: -shared
  - id: show_modification_count
    type:
      - 'null'
      - boolean
    doc: show the number of times that the file has been modified on the server 
      even with changes not visible to the user
    inputBinding:
      position: 101
      prefix: -version
  - id: show_owners
    type:
      - 'null'
      - boolean
    doc: shows the owner names per file
    inputBinding:
      position: 101
      prefix: -owners
  - id: skip_mime
    type:
      - 'null'
      - string
    doc: skip elements with mimeTypes derived from these extensions
    inputBinding:
      position: 101
      prefix: -skip-mime
  - id: skip_owner
    type:
      - 'null'
      - string
    doc: ignore elements owned by these users
    inputBinding:
      position: 101
      prefix: -skip-owner
  - id: sort
    type:
      - 'null'
      - string
    doc: sort items by a combination of attributes (e.g., modtime,md5_r,name)
    inputBinding:
      position: 101
      prefix: -sort
  - id: trashed
    type:
      - 'null'
      - boolean
    doc: list content in the trash
    inputBinding:
      position: 101
      prefix: -trashed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_ls.out
