cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - stats
label: toil_stats
doc: "The location of the job store for the workflow. A job store holds persistent
  information about the jobs, stats, and files in a workflow.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: string
    doc: The location of the job store for the workflow. A job store holds 
      persistent information about the jobs, stats, and files in a workflow. Can
      be file:<path>, aws:<region>:<prefix>, or google:<project_id>:<prefix>.
    inputBinding:
      position: 1
  - id: categories
    type:
      - 'null'
      - string
    doc: "Comma separated list of any of the following: ['time', 'clock', 'wait',
      'memory', 'disk']."
    inputBinding:
      position: 102
      prefix: --categories
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
    doc: Turn on loglevel Critical.
    inputBinding:
      position: 102
      prefix: --logCritical
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Debug.
    inputBinding:
      position: 102
      prefix: --logDebug
  - id: log_error
    type:
      - 'null'
      - boolean
    doc: Turn on loglevel Error.
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
    doc: Turn on loglevel Info.
    inputBinding:
      position: 102
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level.
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
    doc: Turn on loglevel Warning.
    inputBinding:
      position: 102
      prefix: --logWarning
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: if not raw, prettify the numbers to be human readable.
    inputBinding:
      position: 102
      prefix: --pretty
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Return raw json data.
    inputBinding:
      position: 102
      prefix: --raw
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files from getting too 
      big.
    inputBinding:
      position: 102
      prefix: --rotatingLogging
  - id: sort
    type:
      - 'null'
      - string
    doc: 'Sort direction. Options: ascending, decending'
    inputBinding:
      position: 102
      prefix: --sort
  - id: sort_category
    type:
      - 'null'
      - string
    doc: 'How to sort job categories. Options: time, clock, wait, memory, disk, alpha,
      count'
    inputBinding:
      position: 102
      prefix: --sortCategory
  - id: sort_field
    type:
      - 'null'
      - string
    doc: 'How to sort job fields. Options: min, med, ave, max, total'
    inputBinding:
      position: 102
      prefix: --sortField
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File in which to write results.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
