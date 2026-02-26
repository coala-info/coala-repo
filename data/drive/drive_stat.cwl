cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_stat
label: drive_stat
doc: "Statistics about files and directories.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: depth
    type:
      - 'null'
      - int
    doc: max traversal depth
    default: 1
    inputBinding:
      position: 101
      prefix: -depth
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: discover hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: md5sum_compatible
    type:
      - 'null'
      - boolean
    doc: produce output compatible with md5sum(1)
    inputBinding:
      position: 101
      prefix: -md5sum
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
    doc: recursively discover folders
    inputBinding:
      position: 101
      prefix: -recursive
  - id: stat_by_id
    type:
      - 'null'
      - boolean
    doc: stat by id instead of path
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
stdout: drive_stat.out
