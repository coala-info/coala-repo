cwlVersion: v1.2
class: CommandLineTool
baseCommand: numfmt
label: coreutils_numfmt
doc: "Reformat NUMBER(s), or the numbers from standard input if none are specified.\n
  \nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: numbers
    type:
      - 'null'
      - type: array
        items: string
    doc: NUMBER(s) to reformat
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print warnings about invalid input
    inputBinding:
      position: 102
      prefix: --debug
  - id: delimiter
    type:
      - 'null'
      - string
    doc: use X instead of whitespace for field delimiter
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: field
    type:
      - 'null'
      - string
    doc: replace the numbers in these input fields
    default: '1'
    inputBinding:
      position: 102
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: use printf style floating-point FORMAT
    inputBinding:
      position: 102
      prefix: --format
  - id: from
    type:
      - 'null'
      - string
    doc: auto-scale input numbers to UNITs; default is 'none'
    default: none
    inputBinding:
      position: 102
      prefix: --from
  - id: from_unit
    type:
      - 'null'
      - int
    doc: specify the input unit size (instead of the default 1)
    default: 1
    inputBinding:
      position: 102
      prefix: --from-unit
  - id: grouping
    type:
      - 'null'
      - boolean
    doc: use locale-defined grouping of digits, e.g. 1,000,000
    inputBinding:
      position: 102
      prefix: --grouping
  - id: header
    type:
      - 'null'
      - int
    doc: print (without converting) the first N header lines; N defaults to 1 if not
      specified
    inputBinding:
      position: 102
      prefix: --header
  - id: invalid
    type:
      - 'null'
      - string
    doc: 'failure mode for invalid numbers: abort, fail, warn, ignore'
    default: abort
    inputBinding:
      position: 102
      prefix: --invalid
  - id: padding
    type:
      - 'null'
      - int
    doc: pad the output to N characters; positive N will right-align; negative N will
      left-align
    inputBinding:
      position: 102
      prefix: --padding
  - id: round
    type:
      - 'null'
      - string
    doc: 'use METHOD for rounding when scaling: up, down, from-zero, towards-zero,
      nearest'
    default: from-zero
    inputBinding:
      position: 102
      prefix: --round
  - id: suffix
    type:
      - 'null'
      - string
    doc: add SUFFIX to output numbers, and accept optional SUFFIX in input numbers
    inputBinding:
      position: 102
      prefix: --suffix
  - id: to
    type:
      - 'null'
      - string
    doc: auto-scale output numbers to UNITs
    inputBinding:
      position: 102
      prefix: --to
  - id: to_unit
    type:
      - 'null'
      - int
    doc: the output unit size (instead of the default 1)
    default: 1
    inputBinding:
      position: 102
      prefix: --to-unit
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: line delimiter is NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero-terminated
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_numfmt.out
