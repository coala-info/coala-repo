cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/cat
label: coreutils_cat
doc: Concatenate FILE(s) to standard output.
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: FILE(s) to concatenate. With no FILE, or when FILE is -, read standard 
      input.
    inputBinding:
      position: 1
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: equivalent to -vET
    inputBinding:
      position: 102
      prefix: --show-all
  - id: number_nonblank
    type:
      - 'null'
      - boolean
    doc: number nonempty output lines, overrides -n
    inputBinding:
      position: 102
      prefix: --number-nonblank
  - id: show_nonprinting_ends
    type:
      - 'null'
      - boolean
    doc: equivalent to -vE
    inputBinding:
      position: 102
      prefix: -e
  - id: show_ends
    type:
      - 'null'
      - boolean
    doc: display $ at end of each line
    inputBinding:
      position: 102
      prefix: --show-ends
  - id: number
    type:
      - 'null'
      - boolean
    doc: number all output lines
    inputBinding:
      position: 102
      prefix: --number
  - id: squeeze_blank
    type:
      - 'null'
      - boolean
    doc: suppress repeated empty output lines
    inputBinding:
      position: 102
      prefix: --squeeze-blank
  - id: show_nonprinting_tabs
    type:
      - 'null'
      - boolean
    doc: equivalent to -vT
    inputBinding:
      position: 102
      prefix: -t
  - id: show_tabs
    type:
      - 'null'
      - boolean
    doc: display TAB characters as ^I
    inputBinding:
      position: 102
      prefix: --show-tabs
  - id: ignored
    type:
      - 'null'
      - boolean
    doc: (ignored)
    inputBinding:
      position: 102
      prefix: -u
  - id: show_nonprinting
    type:
      - 'null'
      - boolean
    doc: use ^ and M- notation, except for LFD and TAB
    inputBinding:
      position: 102
      prefix: --show-nonprinting
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: cat.out
s:url: https://www.gnu.org/software/coreutils/
$namespaces:
  s: https://schema.org/
