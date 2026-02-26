cwlVersion: v1.2
class: CommandLineTool
baseCommand: drive_about
label: drive_about
doc: "Gives information about the drive.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: features
    type:
      - 'null'
      - boolean
    doc: gives information on features present on this drive
    inputBinding:
      position: 101
      prefix: -features
  - id: filesize
    type:
      - 'null'
      - boolean
    doc: prints out information about file sizes e.g the max upload size for a 
      specific file size
    inputBinding:
      position: 101
      prefix: -filesize
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
  - id: quota
    type:
      - 'null'
      - boolean
    doc: prints out quota information for this drive
    inputBinding:
      position: 101
      prefix: -quota
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_about.out
