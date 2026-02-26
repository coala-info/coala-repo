cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_delete
label: drive_delete
doc: "Deletes files or folders from Google Drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows trashing hidden paths
    inputBinding:
      position: 101
      prefix: --hidden
  - id: id
    type:
      - 'null'
      - boolean
    doc: delete by id instead of path
    inputBinding:
      position: 101
      prefix: --id
  - id: matches
    type:
      - 'null'
      - boolean
    doc: search by prefix and delete
    inputBinding:
      position: 101
      prefix: --matches
  - id: no_prompt
    type:
      - 'null'
      - boolean
    doc: disables the prompt
    inputBinding:
      position: 101
      prefix: --no-prompt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_delete.out
