cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - ssh-cluster
label: toil_ssh-cluster
doc: "SSH into a Toil managed cluster\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: cluster_name
    type: string
    doc: The name that the cluster will be identifiable by. Must be lowercase 
      and may not contain the '_' character.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to the SSH command
    inputBinding:
      position: 2
  - id: grafana_port
    type:
      - 'null'
      - int
    doc: Assign a local port to be used for the Grafana dashboard.
    inputBinding:
      position: 103
      prefix: --grafana_port
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: Temporarily disable strict host key checking.
    inputBinding:
      position: 103
      prefix: --insecure
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    inputBinding:
      position: 103
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Critical. Default: INFO.'
    inputBinding:
      position: 103
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Debug. Default: INFO.'
    inputBinding:
      position: 103
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Error. Default: INFO.'
    inputBinding:
      position: 103
      prefix: --logError
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    inputBinding:
      position: 103
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Info. Default: INFO.'
    inputBinding:
      position: 103
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set the log level. Options: ['Critical', 'Error', 'Warning', 'Debug', 'Info',
      'critical', 'error', 'warning', 'debug', 'info', 'CRITICAL', 'ERROR', 'WARNING',
      'DEBUG', 'INFO']."
    inputBinding:
      position: 103
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCRITICAL.
    inputBinding:
      position: 103
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Warning. Default: INFO.'
    inputBinding:
      position: 103
      prefix: --logWarning
  - id: provisioner
    type:
      - 'null'
      - string
    doc: "The provisioner for cluster auto-scaling. Choices: ['aws', 'gce']."
    inputBinding:
      position: 103
      prefix: --provisioner
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    inputBinding:
      position: 103
      prefix: --rotatingLogging
  - id: ssh_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Pass an additional option to the SSH command.
    inputBinding:
      position: 103
      prefix: --sshOption
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created.
    inputBinding:
      position: 103
      prefix: --tempDirRoot
  - id: zone
    type:
      - 'null'
      - string
    doc: The availability zone of the leader.
    inputBinding:
      position: 103
      prefix: --zone
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_ssh-cluster.out
