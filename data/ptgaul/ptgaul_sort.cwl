cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort
label: ptgaul_sort
doc: "Sort lines of text\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to sort
    inputBinding:
      position: 1
  - id: check_sorted
    type:
      - 'null'
      - boolean
    doc: Check whether input is sorted
    inputBinding:
      position: 102
      prefix: -c
  - id: dictionary_order
    type:
      - 'null'
      - boolean
    doc: Dictionary order (blank or alphanumeric only)
    inputBinding:
      position: 102
      prefix: -d
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Field separator
    inputBinding:
      position: 102
      prefix: -t
  - id: general_numeric_sort
    type:
      - 'null'
      - boolean
    doc: General numerical sort
    inputBinding:
      position: 102
      prefix: -g
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case
    inputBinding:
      position: 102
      prefix: -f
  - id: ignore_leading_blanks
    type:
      - 'null'
      - boolean
    doc: Ignore leading blanks
    inputBinding:
      position: 102
      prefix: -b
  - id: ignore_unprintable
    type:
      - 'null'
      - boolean
    doc: Ignore unprintable characters
    inputBinding:
      position: 102
      prefix: -i
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse sort order
    inputBinding:
      position: 102
      prefix: -r
  - id: sort_key
    type:
      - 'null'
      - string
    doc: Sort by Nth field
    inputBinding:
      position: 102
      prefix: -k
  - id: sort_month
    type:
      - 'null'
      - boolean
    doc: Sort month
    inputBinding:
      position: 102
      prefix: -M
  - id: sort_numbers
    type:
      - 'null'
      - boolean
    doc: Sort numbers
    inputBinding:
      position: 102
      prefix: -n
  - id: sort_version
    type:
      - 'null'
      - boolean
    doc: Sort version
    inputBinding:
      position: 102
      prefix: -V
  - id: stable
    type:
      - 'null'
      - boolean
    doc: Stable (don't sort ties alphabetically)
    inputBinding:
      position: 102
      prefix: -s
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Suppress duplicate lines
    inputBinding:
      position: 102
      prefix: -u
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: Lines are terminated by NUL, not newline
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
