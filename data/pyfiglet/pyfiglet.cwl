cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfiglet
label: pyfiglet
doc: "A pure-python FIGlet implementation that renders text into ASCII art banners.\n
  \nTool homepage: https://github.com/pwaller/pyfiglet"
inputs:
  - id: text
    type:
      - 'null'
      - type: array
        items: string
    doc: Text to render into ASCII art
    inputBinding:
      position: 1
  - id: direction
    type:
      - 'null'
      - string
    doc: Set direction text will be formatted in
    inputBinding:
      position: 102
      prefix: --direction
  - id: flip
    type:
      - 'null'
      - boolean
    doc: Flip text, only works with some fonts
    inputBinding:
      position: 102
      prefix: --flip
  - id: font
    type:
      - 'null'
      - string
    doc: Font to render with
    default: standard
    inputBinding:
      position: 102
      prefix: --font
  - id: justify
    type:
      - 'null'
      - string
    doc: Set justification (left, center, right, auto)
    inputBinding:
      position: 102
      prefix: --justify
  - id: list_fonts
    type:
      - 'null'
      - boolean
    doc: Show list of available fonts
    inputBinding:
      position: 102
      prefix: --list_fonts
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse text, only works with some fonts
    inputBinding:
      position: 102
      prefix: --reverse
  - id: width
    type:
      - 'null'
      - int
    doc: Set terminal width
    default: 80
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfiglet:0.7.5--py34_0
stdout: pyfiglet.out
