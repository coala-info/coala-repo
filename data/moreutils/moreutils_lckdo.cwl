cwlVersion: v1.2
class: CommandLineTool
baseCommand: lckdo
label: moreutils_lckdo
doc: "Execute a program with a lock set. If the lock is already held by another
  process the program is not run. Files named in the program arguments are staged
  into the working directory through input_files.\n\nTool homepage: https://github.com/madx/moreutils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_files ? inputs.input_files : [])"
inputs:
  - id: lockfile
    type: string
    doc: Name of the lock file (created in the working directory unless -n is
      set).
    inputBinding:
      position: 2
  - id: program
    type: string
    doc: Program to run with the lock held.
    inputBinding:
      position: 3
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments of the program.
    inputBinding:
      position: 4
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files used by the program; staged in the working directory so the
      program can name them by file name.
  - id: wait
    type:
      - 'null'
      - boolean
    doc: If the lock is already held by another process, wait for it to complete
      instead of failing immediately.
    inputBinding:
      position: 1
      prefix: -w
  - id: wait_seconds
    type:
      - 'null'
      - int
    doc: The same as -w but wait not more than this many seconds.
    inputBinding:
      position: 1
      prefix: -W
  - id: exec_directly
    type:
      - 'null'
      - boolean
    doc: Execute the program directly, no fork/wait (keeps extra open file
      descriptor).
    inputBinding:
      position: 1
      prefix: -e
  - id: no_create
    type:
      - 'null'
      - boolean
    doc: Do not create the lock file if it does not exist.
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_lckdo.out
