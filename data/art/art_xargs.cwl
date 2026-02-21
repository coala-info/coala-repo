cwlVersion: v1.2
class: CommandLineTool
baseCommand: xargs
label: art_xargs
doc: "Run PROG on every item given by stdin\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: prog_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Program and its initial arguments
    inputBinding:
      position: 1
  - id: eof_str
    type:
      - 'null'
      - string
    doc: STR stops input processing
    inputBinding:
      position: 102
      prefix: -E
  - id: exit_if_size_exceeded
    type:
      - 'null'
      - boolean
    doc: Exit if size is exceeded
    inputBinding:
      position: 102
      prefix: -x
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read from FILE instead of stdin
    inputBinding:
      position: 102
      prefix: -a
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Ask user whether to run each command
    inputBinding:
      position: 102
      prefix: -p
  - id: max_args
    type:
      - 'null'
      - int
    doc: Pass no more than N args to PROG
    inputBinding:
      position: 102
      prefix: -n
  - id: max_chars
    type:
      - 'null'
      - int
    doc: Pass command line of no more than N bytes
    inputBinding:
      position: 102
      prefix: -s
  - id: max_procs
    type:
      - 'null'
      - int
    doc: Run up to N PROGs in parallel
    inputBinding:
      position: 102
      prefix: -P
  - id: no_run_if_empty
    type:
      - 'null'
      - boolean
    doc: Don't run command if input is empty
    inputBinding:
      position: 102
      prefix: -r
  - id: null_terminated
    type:
      - 'null'
      - boolean
    doc: NUL terminated input
    inputBinding:
      position: 102
      prefix: '-0'
  - id: reopen_tty
    type:
      - 'null'
      - boolean
    doc: Reopen stdin as /dev/tty
    inputBinding:
      position: 102
      prefix: -o
  - id: replace_str
    type:
      - 'null'
      - string
    doc: Replace STR within PROG ARGS with input line
    inputBinding:
      position: 102
      prefix: -I
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print the command on stderr before execution
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_xargs.out
