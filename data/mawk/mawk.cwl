cwlVersion: v1.2
class: CommandLineTool
baseCommand: mawk
label: mawk
doc: "mawk [Options] [Program] [file ...]\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs:
  - id: program_text
    type:
      - 'null'
      - string
    doc: Program text
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 2
  - id: dump
    type:
      - 'null'
      - boolean
    doc: show assembler-like listing of program and exit.
    inputBinding:
      position: 103
      prefix: -W dump
  - id: end_of_options
    type:
      - 'null'
      - boolean
    doc: unambiguous end of options.
    inputBinding:
      position: 103
      prefix: --
  - id: exec_file
    type:
      - 'null'
      - File
    doc: use file as program as well as last option.
    inputBinding:
      position: 103
      prefix: -W exec
  - id: field_separator
    type:
      - 'null'
      - string
    doc: sets the field separator, FS, to value.
    inputBinding:
      position: 103
      prefix: -F
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: set unbuffered output, line-buffered input.
    inputBinding:
      position: 103
      prefix: -W interactive
  - id: posix_space
    type:
      - 'null'
      - boolean
    doc: do not consider "\n" a space.
    inputBinding:
      position: 103
      prefix: -W posix_space
  - id: program_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Program text is read from file instead of from the command-line. 
      Multiple -f options are accepted.
    inputBinding:
      position: 103
      prefix: -f
  - id: random_seed
    type:
      - 'null'
      - int
    doc: set initial random seed.
    inputBinding:
      position: 103
      prefix: -W random
  - id: sprintf_buffer_size
    type:
      - 'null'
      - int
    doc: adjust size of sprintf buffer.
    inputBinding:
      position: 103
      prefix: -W sprintf
  - id: variable_assignment
    type:
      - 'null'
      - type: array
        items: string
    doc: assigns value to program variable var.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mawk:1.3.4--h7b50bb2_11
stdout: mawk.out
