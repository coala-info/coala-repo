cwlVersion: v1.2
class: CommandLineTool
baseCommand: galileo
label: galileo_interactive
doc: "synchronize Fitbit trackers with Fitbit web service\n\nTool homepage: https://github.com/JaredC01/Galileo2"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: The mode to run (default to sync)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: use alternative configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: daemon_period
    type:
      - 'null'
      - int
    doc: sleep time in msec between sync runs when in daemon mode
    inputBinding:
      position: 102
      prefix: --daemon-period
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show internal activity (implies verbose)
    inputBinding:
      position: 102
      prefix: --debug
  - id: dump
    type:
      - 'null'
      - boolean
    doc: whether or not to enable saving of the megadump to file
    inputBinding:
      position: 102
      prefix: --dump
  - id: dump_dir
    type:
      - 'null'
      - Directory
    doc: directory for storing dumps
    inputBinding:
      position: 102
      prefix: --dump-dir
  - id: exclude_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: list of tracker IDs to not sync
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fitbit_server
    type:
      - 'null'
      - string
    doc: server used for synchronisation
    inputBinding:
      position: 102
      prefix: --fitbit-server
  - id: force
    type:
      - 'null'
      - boolean
    doc: whether or not to synchronize even if tracker reports a recent sync
    inputBinding:
      position: 102
      prefix: --force
  - id: https_only
    type:
      - 'null'
      - boolean
    doc: whether or not to use http if https is not available
    inputBinding:
      position: 102
      prefix: --https-only
  - id: include_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: list of tracker IDs to sync (all if not specified)
    inputBinding:
      position: 102
      prefix: --include
  - id: log_size
    type:
      - 'null'
      - int
    doc: Amount of communication to display in case of error
    inputBinding:
      position: 102
      prefix: --log-size
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: whether or not to enable saving of the megadump to file
    inputBinding:
      position: 102
      prefix: --no-dump
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: whether or not to synchronize even if tracker reports a recent sync
    inputBinding:
      position: 102
      prefix: --no-force
  - id: no_https_only
    type:
      - 'null'
      - boolean
    doc: whether or not to use http if https is not available
    inputBinding:
      position: 102
      prefix: --no-https-only
  - id: no_syslog
    type:
      - 'null'
      - boolean
    doc: whether or not to send output to syslog instead of stderr
    inputBinding:
      position: 102
      prefix: --no-syslog
  - id: no_upload
    type:
      - 'null'
      - boolean
    doc: whether or not to upload the dump to the server
    inputBinding:
      position: 102
      prefix: --no-upload
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only show errors and summary (default)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: syslog
    type:
      - 'null'
      - boolean
    doc: whether or not to send output to syslog instead of stderr
    inputBinding:
      position: 102
      prefix: --syslog
  - id: upload
    type:
      - 'null'
      - boolean
    doc: whether or not to upload the dump to the server
    inputBinding:
      position: 102
      prefix: --upload
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display synchronization progress
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galileo:v0.5.1-6-deb_cv1
stdout: galileo_interactive.out
