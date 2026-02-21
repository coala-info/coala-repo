cwlVersion: v1.2
class: CommandLineTool
baseCommand: cat
label: cat
doc: "Concatenate FILE(s) to standard output.\n\nTool homepage: https://github.com/dutilh/CAT"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: With no FILE, or when FILE is -, read standard input.
    inputBinding:
      position: 1
  - id: number
    type:
      - 'null'
      - boolean
    doc: number all output lines
    inputBinding:
      position: 102
      prefix: --number
  - id: number_nonblank
    type:
      - 'null'
      - boolean
    doc: number nonempty output lines, overrides -n
    inputBinding:
      position: 102
      prefix: --number-nonblank
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: equivalent to -vET
    inputBinding:
      position: 102
      prefix: --show-all
  - id: show_ends
    type:
      - 'null'
      - boolean
    doc: display $ at end of each line
    inputBinding:
      position: 102
      prefix: --show-ends
  - id: show_nonprinting
    type:
      - 'null'
      - boolean
    doc: use ^ and M- notation, except for LFD and TAB
    inputBinding:
      position: 102
      prefix: --show-nonprinting
  - id: show_tabs
    type:
      - 'null'
      - boolean
    doc: display TAB characters as ^I
    inputBinding:
      position: 102
      prefix: --show-tabs
  - id: squeeze_blank
    type:
      - 'null'
      - boolean
    doc: suppress repeated empty output lines
    inputBinding:
      position: 102
      prefix: --squeeze-blank
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: cat.out
