cwlVersion: v1.2
class: CommandLineTool
baseCommand: flock
label: flock
doc: "Manage file locks from shell scripts\n\nTool homepage: https://github.com/ClusterHQ/flocker"
inputs:
  - id: target
    type: File
    doc: The file or directory to lock, or a file descriptor number
    inputBinding:
      position: 1
  - id: command
    type:
      - 'null'
      - string
    doc: The command to execute while holding the lock
    inputBinding:
      position: 2
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 3
  - id: close
    type:
      - 'null'
      - boolean
    doc: Close file descriptor before running command
    inputBinding:
      position: 104
      prefix: --close
  - id: conflict_exit_code
    type:
      - 'null'
      - int
    doc: Exit code to use after conflict or timeout
    inputBinding:
      position: 104
      prefix: --conflict-exit-code
  - id: exclusive
    type:
      - 'null'
      - boolean
    doc: Get an exclusive lock (default)
    inputBinding:
      position: 104
      prefix: --exclusive
  - id: nonblock
    type:
      - 'null'
      - boolean
    doc: Fail rather than wait
    inputBinding:
      position: 104
      prefix: --nonblock
  - id: run_command
    type:
      - 'null'
      - string
    doc: Run a single command string through the shell
    inputBinding:
      position: 104
      prefix: --command
  - id: shared
    type:
      - 'null'
      - boolean
    doc: Get a shared lock
    inputBinding:
      position: 104
      prefix: --shared
  - id: timeout
    type:
      - 'null'
      - float
    doc: Wait for a limited amount of time (seconds)
    inputBinding:
      position: 104
      prefix: --timeout
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Remove a lock
    inputBinding:
      position: 104
      prefix: --unlock
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flock:1.0--0
stdout: flock.out
