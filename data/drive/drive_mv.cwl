cwlVersion: v1.2
class: CommandLineTool
baseCommand: mv
label: drive_mv
doc: "Move files or directories.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: keep_parent
    type:
      - 'null'
      - boolean
    doc: ensures that when moving a file into a destination, that we also retain
      its original parent so that it will exist in more than one folder
    inputBinding:
      position: 101
      prefix: -keep-parent
  - id: move_by_id
    type:
      - 'null'
      - boolean
    doc: move by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_mv.out
