cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniq
label: coreutils_uniq
doc: "Filter adjacent matching lines from INPUT (or standard input), writing to OUTPUT
  (or standard output).\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input file (or standard input)
    inputBinding:
      position: 1
  - id: all_repeated_method
    type:
      - 'null'
      - string
    doc: like -D, but allow separating groups with an empty line; METHOD={none(default),prepend,separate}
    default: none
    inputBinding:
      position: 102
      prefix: --all-repeated
  - id: check_chars
    type:
      - 'null'
      - int
    doc: compare no more than N characters in lines
    inputBinding:
      position: 102
      prefix: --check-chars
  - id: count
    type:
      - 'null'
      - boolean
    doc: prefix lines by the number of occurrences
    inputBinding:
      position: 102
      prefix: --count
  - id: group_method
    type:
      - 'null'
      - string
    doc: show all items, separating groups with an empty line; METHOD={separate(default),prepend,append,both}
    default: separate
    inputBinding:
      position: 102
      prefix: --group
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore differences in case when comparing
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: print_all_repeated
    type:
      - 'null'
      - boolean
    doc: print all duplicate lines
    inputBinding:
      position: 102
      prefix: -D
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: only print duplicate lines, one for each group
    inputBinding:
      position: 102
      prefix: --repeated
  - id: skip_chars
    type:
      - 'null'
      - int
    doc: avoid comparing the first N characters
    inputBinding:
      position: 102
      prefix: --skip-chars
  - id: skip_fields
    type:
      - 'null'
      - int
    doc: avoid comparing the first N fields
    inputBinding:
      position: 102
      prefix: --skip-fields
  - id: unique
    type:
      - 'null'
      - boolean
    doc: only print unique lines
    inputBinding:
      position: 102
      prefix: --unique
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: line delimiter is NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero-terminated
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file (or standard output)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
