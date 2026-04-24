cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_rename
label: drive_rename
doc: "Rename a file or directory on Google Drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: coerce rename even if remote already exists
    inputBinding:
      position: 101
      prefix: -force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
  - id: rename_local
    type:
      - 'null'
      - boolean
    doc: rename local as well (default true)
    inputBinding:
      position: 101
      prefix: -local
  - id: rename_remote
    type:
      - 'null'
      - boolean
    doc: rename remote as well (default true)
    inputBinding:
      position: 101
      prefix: -remote
  - id: unshare_by_id
    type:
      - 'null'
      - boolean
    doc: unshare by id instead of path
    inputBinding:
      position: 101
      prefix: -id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_rename.out
