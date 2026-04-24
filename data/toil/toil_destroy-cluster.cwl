cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - destroy-cluster
label: toil_destroy-cluster
doc: "Destroy a Toil cluster\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: cluster_name
    type: string
    doc: The name that the cluster will be identifiable by. Must be lowercase 
      and may not contain the '_' character.
    inputBinding:
      position: 1
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    inputBinding:
      position: 102
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Critical. Default: INFO.'
    inputBinding:
      position: 102
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Debug. Default: INFO.'
    inputBinding:
      position: 102
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Error. Default: INFO.'
    inputBinding:
      position: 102
      prefix: --logError
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    inputBinding:
      position: 102
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Info. Default: INFO.'
    inputBinding:
      position: 102
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set the log level. Options: ['Critical', 'Error', 'Warning', 'Debug', 'Info',
      'critical', 'error', 'warning', 'debug', 'info', 'CRITICAL', 'ERROR', 'WARNING',
      'DEBUG', 'INFO']."
    inputBinding:
      position: 102
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCRITICAL.
    inputBinding:
      position: 102
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Warning. Default: INFO.'
    inputBinding:
      position: 102
      prefix: --logWarning
  - id: provisioner
    type:
      - 'null'
      - string
    doc: "The provisioner for cluster auto-scaling. Choices: ['aws', 'gce']."
    inputBinding:
      position: 102
      prefix: --provisioner
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    inputBinding:
      position: 102
      prefix: --rotatingLogging
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created, by default generates a fresh tmp dir with 
      'tempfile.gettempdir()'.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
  - id: zone
    type:
      - 'null'
      - string
    doc: The availability zone of the leader. This parameter can also be set via
      the 'TOIL_X_ZONE' environment variable.
    inputBinding:
      position: 102
      prefix: --zone
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_destroy-cluster.out
