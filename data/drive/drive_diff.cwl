cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff
label: drive_diff
doc: "Compares files or directories.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: base_local
    type:
      - 'null'
      - boolean
    doc: when set uses local as the base other remote will be used as the base
    inputBinding:
      position: 101
      prefix: -base-local
  - id: depth
    type:
      - 'null'
      - int
    doc: max traversal depth
    inputBinding:
      position: 101
      prefix: -depth
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows pulling of hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: ignore_checksum
    type:
      - 'null'
      - boolean
    doc: avoids computation of checksums as a final check.
    inputBinding:
      position: 101
      prefix: -ignore-checksum
  - id: ignore_conflict
    type:
      - 'null'
      - boolean
    doc: turns off the conflict resolution safety
    inputBinding:
      position: 101
      prefix: -ignore-conflict
  - id: ignore_name_clashes
    type:
      - 'null'
      - boolean
    doc: ignore name clashes
    inputBinding:
      position: 101
      prefix: -ignore-name-clashes
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
    doc: recursively diff
    inputBinding:
      position: 101
      prefix: -recursive
  - id: skip_content_check
    type:
      - 'null'
      - boolean
    doc: skip diffing actual body content, show only name, time, type changes
    inputBinding:
      position: 101
      prefix: -skip-content-check
  - id: unified_diff
    type:
      - 'null'
      - boolean
    doc: unified diff
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_diff.out
