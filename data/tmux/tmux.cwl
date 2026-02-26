cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmux
label: tmux
doc: "tmux is a terminal multiplexer\n\nTool homepage: https://github.com/tmux/tmux"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Flags for the command
    inputBinding:
      position: 2
  - id: _colors
    type:
      - 'null'
      - boolean
    doc: Declare the terminal to be "256-colour"
    inputBinding:
      position: 103
      prefix: '-2'
  - id: config_file
    type:
      - 'null'
      - File
    doc: Use file as configuration file
    inputBinding:
      position: 103
      prefix: -f
  - id: curses
    type:
      - 'null'
      - boolean
    doc: Use curses instead of the terminfo database
    inputBinding:
      position: 103
      prefix: -C
  - id: lock
    type:
      - 'null'
      - boolean
    doc: Lock the server
    inputBinding:
      position: 103
      prefix: -l
  - id: shell_command
    type:
      - 'null'
      - string
    doc: Execute shell-command
    inputBinding:
      position: 103
      prefix: -c
  - id: socket_name
    type:
      - 'null'
      - string
    doc: Specify socket name
    inputBinding:
      position: 103
      prefix: -L
  - id: socket_path
    type:
      - 'null'
      - File
    doc: Specify socket path
    inputBinding:
      position: 103
      prefix: -S
  - id: user_mode
    type:
      - 'null'
      - boolean
    doc: Set user mode
    inputBinding:
      position: 103
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmux:2.1--1
stdout: tmux.out
