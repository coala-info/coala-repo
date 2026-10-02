cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfiglet
label: pyfiglet
doc: Render text using FIGlet fonts
inputs:
  - id: text
    type:
      - 'null'
      - type: array
        items: string
    doc: Text to render
    inputBinding:
      position: 1
  - id: font
    type:
      - 'null'
      - string
    doc: 'font to render with (default: standard)'
    inputBinding:
      position: 102
      prefix: --font
  - id: direction
    type:
      - 'null'
      - string
    doc: 'set direction text will be formatted in (default: auto)'
    inputBinding:
      position: 102
      prefix: --direction
  - id: justify
    type:
      - 'null'
      - string
    doc: set justification, defaults to print direction
    inputBinding:
      position: 102
      prefix: --justify
  - id: width
    type:
      - 'null'
      - int
    doc: 'set terminal width for wrapping/justification (default: 80)'
    inputBinding:
      position: 102
      prefix: --width
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: shows mirror image of output text
    inputBinding:
      position: 102
      prefix: --reverse
  - id: flip
    type:
      - 'null'
      - boolean
    doc: flips rendered output text over
    inputBinding:
      position: 102
      prefix: --flip
  - id: list_fonts
    type:
      - 'null'
      - boolean
    doc: show installed fonts list
    inputBinding:
      position: 102
      prefix: --list_fonts
  - id: info_font
    type:
      - 'null'
      - boolean
    doc: show font's information, use with -f FONT
    inputBinding:
      position: 102
      prefix: --info_font
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfiglet:0.7.5--py34_0
stdout: pyfiglet.out
s:url: https://github.com/pwaller/pyfiglet
$namespaces:
  s: https://schema.org/
