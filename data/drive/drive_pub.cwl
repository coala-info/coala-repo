cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_pub
label: drive_pub
doc: "Usage of pub\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows publishing of hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: id
    type:
      - 'null'
      - boolean
    doc: publish by id instead of path
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
stdout: drive_pub.out
