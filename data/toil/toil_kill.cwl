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
    type: Directory
    doc: 'The job store directory of the workflow (a file job store). A job store holds persistent information about the jobs, stats, and files in a workflow.'
    inputBinding:
      position: 1
      valueFrom: $(runtime.outdir + '/' + self.basename)
  - id: force
    type:
      - 'null'
      - boolean
    doc: Send SIGKILL to the leader process if local.
    inputBinding:
      position: 102
      prefix: --force
  - id: log_colors
    type:
      - 'null'
      - string
    doc: Enable or disable colored logging (True or False).
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
      - string
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
      - string
    doc: Path to where temporary directory containing all temp files are 
      created, by default generates a fresh tmp dir with 
      'tempfile.gettempdir()'.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
outputs:
  - id: job_store_after
    type:
      - 'null'
      - Directory
    doc: The job store directory after the command (absent when the job store was deleted)
    outputBinding:
      glob: $(inputs.job_store.basename)
  - id: log_file_out
    type:
      - 'null'
      - File
    doc: Log file written with --logFile
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.job_store)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_kill.out
