cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - debug-job
label: toil_debug-job
doc: "Debug a job within a Toil workflow by running it or retrieving its task directory.\n\
  \nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: string
    doc: The location of the job store for the workflow. A job store holds 
      persistent information about the jobs, stats, and files in a workflow.
    inputBinding:
      position: 1
  - id: job
    type: string
    doc: The job store id or job name of a job within the provided jobstore
    inputBinding:
      position: 2
  - id: log_colors
    type:
      - 'null'
      - boolean
    doc: Enable or disable colored logging.
    default: true
    inputBinding:
      position: 103
      prefix: --logColors
  - id: log_critical
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Critical.
    inputBinding:
      position: 103
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Debug.
    inputBinding:
      position: 103
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Error.
    inputBinding:
      position: 103
      prefix: --logError
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Info.
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
    default: DEBUG
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
    doc: Turn on loglevel Warning.
    inputBinding:
      position: 103
      prefix: --logWarning
  - id: print_job_info
    type:
      - 'null'
      - boolean
    doc: Dump debugging info about the job instead of running it
    default: false
    inputBinding:
      position: 103
      prefix: --printJobInfo
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    default: false
    inputBinding:
      position: 103
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
      position: 103
      prefix: --tempDirRoot
outputs:
  - id: retrieve_task_directory
    type:
      - 'null'
      - Directory
    doc: Download CWL or WDL task inputs to the given directory and stop.
    outputBinding:
      glob: $(inputs.retrieve_task_directory)
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
