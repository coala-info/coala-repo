cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diff3
label: diffutils_diff3
doc: "Compare three files line by line.\n\nTool homepage: https://www.gnu.org/software/diffutils/"
inputs:
  - id: myfile
    type: File
    doc: First file to compare (usually your modified version)
    inputBinding:
      position: 1
  - id: oldfile
    type: File
    doc: Second file to compare (usually the common ancestor)
    inputBinding:
      position: 2
  - id: yourfile
    type: File
    doc: Third file to compare (usually the other modified version)
    inputBinding:
      position: 3
  - id: append_write_quit
    type:
      - 'null'
      - boolean
    doc: append 'w' and 'q' commands to ed scripts
    inputBinding:
      position: 104
      prefix: -i
  - id: diff_program
    type:
      - 'null'
      - string
    doc: use PROGRAM to compare files
    inputBinding:
      position: 104
      prefix: --diff-program=
      separate: false
  - id: easy_only
    type:
      - 'null'
      - boolean
    doc: like -e, but incorporate only nonoverlapping changes
    inputBinding:
      position: 104
      prefix: --easy-only
  - id: ed
    type:
      - 'null'
      - boolean
    doc: output ed script incorporating changes from OLDFILE to YOURFILE into MYFILE
    inputBinding:
      position: 104
      prefix: --ed
  - id: initial_tab
    type:
      - 'null'
      - boolean
    doc: make tabs line up by prepending a tab
    inputBinding:
      position: 104
      prefix: --initial-tab
  - id: label
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --label
          separate: true
    doc: use LABEL instead of file name (can be repeated up to three times)
    inputBinding:
      position: 104
  - id: merge
    type:
      - 'null'
      - boolean
    doc: output merged file instead of ed script
    inputBinding:
      position: 104
      prefix: --merge
  - id: overlap_only
    type:
      - 'null'
      - boolean
    doc: like -e, but incorporate only overlapping changes
    inputBinding:
      position: 104
      prefix: --overlap-only
  - id: overlap_only_bracket
    type:
      - 'null'
      - boolean
    doc: like -x, but bracket conflicts
    inputBinding:
      position: 104
      prefix: -X
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: output all changes, bracketing conflicts
    inputBinding:
      position: 104
      prefix: --show-all
  - id: show_overlap
    type:
      - 'null'
      - boolean
    doc: like -e, but bracket conflicts
    inputBinding:
      position: 104
      prefix: --show-overlap
  - id: text
    type:
      - 'null'
      - boolean
    doc: treat all files as text
    inputBinding:
      position: 104
      prefix: --text
  - id: strip_trailing_cr
    type:
      - 'null'
      - boolean
    doc: strip trailing carriage return on input
    inputBinding:
      position: 104
      prefix: --strip-trailing-cr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffutils:3.10
stdout: diffutils_diff3.out
successCodes:
  - 0
  - 1
