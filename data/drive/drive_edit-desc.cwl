cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_edit-desc
label: drive_edit-desc
doc: "Edit the description of a drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: description
    type:
      - 'null'
      - string
    doc: set the description
    inputBinding:
      position: 101
      prefix: -description
  - id: id
    type:
      - 'null'
      - boolean
    doc: open by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: piped
    type:
      - 'null'
      - boolean
    doc: get content in from standard input (stdin)
    inputBinding:
      position: 101
      prefix: -piped
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_edit-desc.out
