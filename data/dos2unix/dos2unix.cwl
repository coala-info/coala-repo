cwlVersion: v1.2
class: CommandLineTool
baseCommand: dos2unix
label: dos2unix
doc: "DOS/Mac to Unix and vice versa text file format converter\n\nTool homepage:
  https://github.com/JamesMGreene/node-dos2unix"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to convert in-place
    inputBinding:
      position: 1
  - id: convmode
    type:
      - 'null'
      - string
    doc: 'Conversion mode: ASCII, 7bit, ISO, Mac (default: ASCII)'
    inputBinding:
      position: 102
      prefix: --convmode
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force conversion of binary files
    inputBinding:
      position: 102
      prefix: --force
  - id: keepdate
    type:
      - 'null'
      - boolean
    doc: Keep output file date
    inputBinding:
      position: 102
      prefix: --keepdate
  - id: newfile
    type:
      - 'null'
      - boolean
    doc: Write to new file (follow with infile outfile)
    inputBinding:
      position: 102
      prefix: --newfile
  - id: oldfile
    type:
      - 'null'
      - boolean
    doc: Write to old file (default)
    inputBinding:
      position: 102
      prefix: --oldfile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode, suppress all warnings
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dos2unix:7.5.3
stdout: dos2unix.out
