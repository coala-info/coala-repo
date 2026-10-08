cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galileo
label: galileo_sync
doc: "Synchronize Fitbit trackers with the Fitbit web service through a Fitbit USB dongle (one run).\n\nTool homepage: https://bitbucket.org/benallard/galileo"
arguments:
  - position: 10
    valueFrom: sync
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "use alternative configuration file (default to None)"
    inputBinding:
      position: 1
      prefix: --config
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "display synchronization progress"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "show internal activity (implies verbose)"
    inputBinding:
      position: 1
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "only show errors and summary (default)"
    inputBinding:
      position: 1
      prefix: --quiet
  - id: log_size
    type:
      - 'null'
      - int
    doc: "Amount of communication to display in case of error (default to 10)"
    inputBinding:
      position: 1
      prefix: --log-size
  - id: syslog
    type:
      - 'null'
      - boolean
    doc: "send output to syslog instead of stderr"
    inputBinding:
      position: 1
      prefix: --syslog
  - id: no_syslog
    type:
      - 'null'
      - boolean
    doc: "send output to stderr (default)"
    inputBinding:
      position: 1
      prefix: --no-syslog
  - id: dump_dir
    type:
      - 'null'
      - string
    doc: "directory for storing dumps (default to ~/.galileo)"
    inputBinding:
      position: 1
      prefix: --dump-dir
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of tracker IDs to sync (all if not specified)"
    inputBinding:
      position: 1
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of tracker IDs to not sync"
    inputBinding:
      position: 1
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: "synchronize even if tracker reports a recent sync"
    inputBinding:
      position: 1
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: "do not synchronize if tracker reports a recent sync (default)"
    inputBinding:
      position: 1
      prefix: --no-force
  - id: dump
    type:
      - 'null'
      - boolean
    doc: "save the megadump to file (default)"
    inputBinding:
      position: 1
      prefix: --dump
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: "do not save the megadump to file"
    inputBinding:
      position: 1
      prefix: --no-dump
  - id: upload
    type:
      - 'null'
      - boolean
    doc: "upload the dump to the server (default)"
    inputBinding:
      position: 1
      prefix: --upload
  - id: no_upload
    type:
      - 'null'
      - boolean
    doc: "do not upload the dump to the server"
    inputBinding:
      position: 1
      prefix: --no-upload
  - id: fitbit_server
    type:
      - 'null'
      - string
    doc: "server used for synchronisation (default to client.fitbit.com)"
    inputBinding:
      position: 1
      prefix: --fitbit-server
  - id: https_only
    type:
      - 'null'
      - boolean
    doc: "do not use http if https is not available (default)"
    inputBinding:
      position: 1
      prefix: --https-only
  - id: no_https_only
    type:
      - 'null'
      - boolean
    doc: "use http if https is not available"
    inputBinding:
      position: 1
      prefix: --no-https-only
outputs:
  - id: log
    type: stdout
    doc: "Status messages."
  - id: dumps
    type:
      - 'null'
      - Directory
    doc: "Directory with the saved tracker dumps."
    outputBinding:
      glob: $(inputs.dump_dir)
stdout: galileo_sync.log
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galileo:v0.5.1-6-deb_cv1
