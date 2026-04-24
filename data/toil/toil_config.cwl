cwlVersion: v1.2
class: CommandLineTool
baseCommand: toil
label: toil_config
doc: "Generate a configuration file for Toil.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    inputBinding:
      position: 101
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Critical. Default: INFO.'
    inputBinding:
      position: 101
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Debug. Default: INFO.'
    inputBinding:
      position: 101
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Error. Default: INFO.'
    inputBinding:
      position: 101
      prefix: --logError
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Info. Default: INFO.'
    inputBinding:
      position: 101
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set the log level. Options: ['Critical', 'Error', 'Warning', 'Debug', 'Info',
      'critical', 'error', 'warning', 'debug', 'info', 'CRITICAL', 'ERROR', 'WARNING',
      'DEBUG', 'INFO']."
    inputBinding:
      position: 101
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Same as --logCRITICAL.
    inputBinding:
      position: 101
      prefix: --logOff
  - id: log_warning
    type:
      - 'null'
      - boolean
    doc: 'Turn on loglevel Warning. Default: INFO.'
    inputBinding:
      position: 101
      prefix: --logWarning
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    inputBinding:
      position: 101
      prefix: --rotatingLogging
outputs:
  - id: output
    type: File
    doc: Filepath to write the config file too.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
