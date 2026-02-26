cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_trash
label: drive_trash
doc: "Trash files and directories.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: allow_hidden
    type:
      - 'null'
      - boolean
    doc: allows trashing hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
  - id: search_and_trash
    type:
      - 'null'
      - boolean
    doc: search by prefix and trash
    inputBinding:
      position: 101
      prefix: -matches
  - id: trash_by_id
    type:
      - 'null'
      - boolean
    doc: trash by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show step by step information verbosely
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_trash.out
