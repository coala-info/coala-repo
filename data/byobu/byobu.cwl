cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmux
label: byobu
doc: "tmux is a terminal multiplexer\n\nTool homepage: https://github.com/dustinkirkland/byobu"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The command to run.
    inputBinding:
      position: 1
  - id: flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Flags for the command.
    inputBinding:
      position: 2
  - id: _colors
    type:
      - 'null'
      - boolean
    doc: Declare the terminal emulator to tmux as supporting 256 colours.
    inputBinding:
      position: 103
      prefix: '-2'
  - id: config_file
    type:
      - 'null'
      - File
    doc: Use file as the tmux configuration file.
    inputBinding:
      position: 103
      prefix: -f
  - id: curses
    type:
      - 'null'
      - boolean
    doc: Declare the terminal emulator to tmux as supporting only 8 colours.
    inputBinding:
      position: 103
      prefix: -C
  - id: lock
    type:
      - 'null'
      - boolean
    doc: tmux is started with the lock option set.
    inputBinding:
      position: 103
      prefix: -l
  - id: shell_command
    type:
      - 'null'
      - string
    doc: Execute shell-command in the shell.
    inputBinding:
      position: 103
      prefix: -c
  - id: socket_name
    type:
      - 'null'
      - string
    doc: Specify the name of the tmux socket.
    inputBinding:
      position: 103
      prefix: -L
  - id: socket_path
    type:
      - 'null'
      - File
    doc: Specify the path of the tmux socket.
    inputBinding:
      position: 103
      prefix: -S
  - id: user_mode
    type:
      - 'null'
      - boolean
    doc: tmux is started with the user mode option set.
    inputBinding:
      position: 103
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra information.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/byobu:5.98--hb42da9c_2
stdout: byobu.out
