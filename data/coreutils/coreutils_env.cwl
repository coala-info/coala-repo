cwlVersion: v1.2
class: CommandLineTool
baseCommand: env
label: coreutils_env
doc: "Set each NAME to VALUE in the environment and run COMMAND. If no COMMAND is
  specified, print the resulting environment.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: env_vars
    type:
      - 'null'
      - type: array
        items: string
    doc: Environment variable definitions in the form NAME=VALUE
    inputBinding:
      position: 1
  - id: command
    type:
      - 'null'
      - string
    doc: The command to execute
    inputBinding:
      position: 2
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the command
    inputBinding:
      position: 3
  - id: chdir
    type:
      - 'null'
      - Directory
    doc: change working directory to DIR
    inputBinding:
      position: 104
      prefix: --chdir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print verbose information for each processing step
    inputBinding:
      position: 104
      prefix: --debug
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: start with an empty environment
    inputBinding:
      position: 104
      prefix: --ignore-environment
  - id: 'null'
    type:
      - 'null'
      - boolean
    doc: end each output line with NUL, not newline
    inputBinding:
      position: 104
      prefix: --null
  - id: split_string
    type:
      - 'null'
      - string
    doc: process and split S into separate arguments; used to pass multiple arguments
      on shebang lines
    inputBinding:
      position: 104
      prefix: --split-string
  - id: unset
    type:
      - 'null'
      - type: array
        items: string
    doc: remove variable from the environment
    inputBinding:
      position: 104
      prefix: --unset
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_env.out
