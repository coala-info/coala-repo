cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_server
label: mrs_server
doc: "\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command, one of start, stop, status or reload
    inputBinding:
      position: 101
      prefix: --command
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: no_daemon
    type:
      - 'null'
      - boolean
    doc: Do not run as background process
    inputBinding:
      position: 101
      prefix: --no-daemon
  - id: pidfile
    type:
      - 'null'
      - File
    doc: Create file with process ID (pid)
    inputBinding:
      position: 101
      prefix: --pidfile
  - id: user
    type:
      - 'null'
      - string
    doc: User to run as (e.g. nobody)
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_server.out
