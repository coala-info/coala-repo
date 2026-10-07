cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/env
label: coreutils_env
doc: Set each NAME to VALUE in the environment and run COMMAND.
inputs:
  - id: environment_variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Set each NAME to VALUE in the environment
    inputBinding:
      position: 2
  - id: command
    type:
      - 'null'
      - string
    doc: Command to run
    inputBinding:
      position: 3
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to COMMAND
    inputBinding:
      position: 4
  - id: argv0
    type:
      - 'null'
      - string
    doc: pass ARG as the zeroth argument of COMMAND
    inputBinding:
      position: 1
      prefix: --argv0
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: start with an empty environment
    inputBinding:
      position: 1
      prefix: --ignore-environment
  - id: 'null'
    type:
      - 'null'
      - boolean
    doc: end each output line with NUL, not newline
    inputBinding:
      position: 1
      prefix: --null
  - id: unset
    type:
      - 'null'
      - string
    doc: remove variable from the environment
    inputBinding:
      position: 1
      prefix: --unset
  - id: chdir
    type:
      - 'null'
      - Directory
    doc: change working directory to DIR
    inputBinding:
      position: 1
      prefix: --chdir
  - id: split_string
    type:
      - 'null'
      - string
    doc: process and split S into separate arguments; used to pass multiple 
      arguments on shebang lines
    inputBinding:
      position: 1
      prefix: --split-string
  - id: block_signal
    type:
      - 'null'
      - type: array
        items: string
    doc: block delivery of SIG signal(s) to COMMAND
    inputBinding:
      position: 1
      prefix: --block-signal=
      separate: false
      itemSeparator: ','
  - id: default_signal
    type:
      - 'null'
      - type: array
        items: string
    doc: reset handling of SIG signal(s) to the default
    inputBinding:
      position: 1
      prefix: --default-signal=
      separate: false
      itemSeparator: ','
  - id: ignore_signal
    type:
      - 'null'
      - type: array
        items: string
    doc: set handling of SIG signal(s) to do nothing
    inputBinding:
      position: 1
      prefix: --ignore-signal=
      separate: false
      itemSeparator: ','
  - id: list_signal_handling
    type:
      - 'null'
      - boolean
    doc: list non default signal handling to stderr
    inputBinding:
      position: 1
      prefix: --list-signal-handling
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print verbose information for each processing step
    inputBinding:
      position: 1
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: env.out
s:url: https://www.gnu.org/software/coreutils/
$namespaces:
  s: https://schema.org/
