cwlVersion: v1.2
class: CommandLineTool
baseCommand: rm
label: art_rm
doc: "Remove (unlink) FILEs\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: FILEs to remove
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Never prompt
    inputBinding:
      position: 102
      prefix: -f
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Always prompt before removing
    inputBinding:
      position: 102
      prefix: -i
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_rm.out
