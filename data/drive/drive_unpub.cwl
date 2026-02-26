cwlVersion: v1.2
class: CommandLineTool
baseCommand: unpub
label: drive_unpub
doc: "Unpublish paths or IDs.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows pulling of hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: id
    type:
      - 'null'
      - boolean
    doc: unpublish by id instead of path
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
stdout: drive_unpub.out
