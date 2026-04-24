cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_open
label: drive_open
doc: "Open files or directories.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: file_browser
    type:
      - 'null'
      - boolean
    doc: open file with the local file manager
    inputBinding:
      position: 101
      prefix: -file-browser
  - id: open_by_id
    type:
      - 'null'
      - boolean
    doc: open by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: web_browser
    type:
      - 'null'
      - boolean
    doc: open file in default browser
    inputBinding:
      position: 101
      prefix: -web-browser
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_open.out
