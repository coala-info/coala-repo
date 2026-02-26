cwlVersion: v1.2
class: CommandLineTool
baseCommand: rm
label: blinker_rm
doc: "Remove (unlink) FILEs\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Files to remove
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
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_rm.out
