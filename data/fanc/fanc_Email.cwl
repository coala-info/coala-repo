cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
label: fanc_Email
doc: "fanc processing tool for Hi-C data. This configuration focuses on the global
  email and logging options.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (e.g., auto, map, pairs, hic, etc.)
    inputBinding:
      position: 1
  - id: email
    type:
      - 'null'
      - string
    doc: Email address for fanc command summary.
    inputBinding:
      position: 102
      prefix: --email
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to file in which to save log.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print log messages to command line.
    inputBinding:
      position: 102
      prefix: --silent
  - id: smtp_password
    type:
      - 'null'
      - string
    doc: SMTP password.
    inputBinding:
      position: 102
      prefix: --smtp-password
  - id: smtp_sender_address
    type:
      - 'null'
      - string
    doc: SMTP sender email address.
    inputBinding:
      position: 102
      prefix: --smtp-sender-address
  - id: smtp_server
    type:
      - 'null'
      - string
    doc: SMTP server in the form smtp.server.com[:port].
    inputBinding:
      position: 102
      prefix: --smtp-server
  - id: smtp_username
    type:
      - 'null'
      - string
    doc: SMTP username.
    inputBinding:
      position: 102
      prefix: --smtp-username
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: 'Set verbosity level: Can be chained like "-vvv" to increase verbosity.'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
stdout: fanc_Email.out
