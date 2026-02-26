cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - kill
label: toil_kill
doc: "Kill a Toil workflow and its associated jobs in the job store.\n\nTool homepage:
  https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: string
    doc: 'The location of the job store for the workflow. A job store holds persistent
      information about the jobs, stats, and files in a workflow. Supported schemes:
      file:<path>, aws:<region>:<prefix>, google:<project_id>:<prefix>.'
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Send SIGKILL to the leader process if local.
    default: false
    inputBinding:
      position: 102
      prefix: --force
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    default: true
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
    default: INFO
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
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    default: false
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
    default: /tmp
    inputBinding:
      position: 102
      prefix: --tempDirRoot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_kill.out
