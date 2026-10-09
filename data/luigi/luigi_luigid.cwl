cwlVersion: v1.2
class: CommandLineTool
baseCommand: luigid
label: luigi_luigid
doc: "Central luigi server (long-running scheduler daemon)\n\nTool homepage: https://github.com/spotify/luigi"
inputs:
  - id: address
    type:
      - 'null'
      - string
    doc: Listening interface
    inputBinding:
      position: 101
      prefix: --address
  - id: background
    type:
      - 'null'
      - boolean
    doc: Run in background mode
    inputBinding:
      position: 101
      prefix: --background
  - id: logdir
    type:
      - 'null'
      - string
    doc: log directory
    inputBinding:
      position: 101
      prefix: --logdir
  - id: pidfile
    type:
      - 'null'
      - string
    doc: Write pidfile
    inputBinding:
      position: 101
      prefix: --pidfile
  - id: port
    type:
      - 'null'
      - int
    doc: Listening port
    inputBinding:
      position: 101
      prefix: --port
  - id: state_path
    type:
      - 'null'
      - string
    doc: Pickled state file
    inputBinding:
      position: 101
      prefix: --state-path
  - id: unix_socket
    type:
      - 'null'
      - string
    doc: Unix socket path
    inputBinding:
      position: 101
      prefix: --unix-socket
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/luigi:phenomenal-v2.6.0_cv0.1.6
stdout: luigid.out
