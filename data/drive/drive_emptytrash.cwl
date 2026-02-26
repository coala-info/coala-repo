cwlVersion: v1.2
class: CommandLineTool
baseCommand: emptytrash
label: drive_emptytrash
doc: "Empties the trash\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: no_prompt
    type:
      - 'null'
      - boolean
    doc: shows no prompt before emptying the trash
    inputBinding:
      position: 101
      prefix: -no-prompt
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
stdout: drive_emptytrash.out
