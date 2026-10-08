cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galileo
label: galileo_interactive
doc: "Start an interactive shell to talk to a Fitbit tracker through the Fitbit USB dongle.\n\nTool homepage: https://bitbucket.org/benallard/galileo"
arguments:
  - position: 10
    valueFrom: interactive
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
outputs:
  - id: log
    type: stdout
    doc: "Status messages."
stdout: galileo_interactive.log
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galileo:v0.5.1-6-deb_cv1
