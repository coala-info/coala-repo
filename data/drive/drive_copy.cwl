cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_copy
label: drive_copy
doc: "Copy files or directories\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: copy_by_id
    type:
      - 'null'
      - boolean
    doc: copy by id instead of path
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
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursive copying
    inputBinding:
      position: 101
      prefix: -recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_copy.out
