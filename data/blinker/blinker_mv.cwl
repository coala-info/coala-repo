cwlVersion: v1.2
class: CommandLineTool
baseCommand: mv
label: blinker_mv
doc: "Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: source
    type: string
    doc: Source file or directory to move/rename
    inputBinding:
      position: 1
  - id: sources
    type:
      type: array
      items: string
    doc: Source files or directories to move
    inputBinding:
      position: 2
  - id: destination
    type: string
    doc: Destination file or directory
    inputBinding:
      position: 3
  - id: directory
    type: Directory
    doc: Directory to move source(s) into
    inputBinding:
      position: 4
  - id: force
    type:
      - 'null'
      - boolean
    doc: Don't prompt before overwriting
    inputBinding:
      position: 105
      prefix: -f
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Interactive, prompt before overwrite
    inputBinding:
      position: 105
      prefix: -i
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Don't overwrite an existing file
    inputBinding:
      position: 105
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_mv.out
