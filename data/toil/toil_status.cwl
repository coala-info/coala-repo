cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - status
label: toil_status
doc: "Report the status of a Toil workflow and its jobs.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: string
    doc: The location of the job store for the workflow. A job store holds 
      persistent information about the jobs, stats, and files in a workflow.
    inputBinding:
      position: 1
  - id: children
    type:
      - 'null'
      - boolean
    doc: Print children of each job.
    default: false
    inputBinding:
      position: 102
      prefix: --children
  - id: dot
    type:
      - 'null'
      - boolean
    doc: Print dot formatted description of the graph. If using --jobs will 
      restrict to subgraph including only those jobs.
    default: false
    inputBinding:
      position: 102
      prefix: --dot
  - id: fail_if_not_complete
    type:
      - 'null'
      - boolean
    doc: Return exit value of 1 if toil jobs not all completed.
    default: false
    inputBinding:
      position: 102
      prefix: --failIfNotComplete
  - id: failed
    type:
      - 'null'
      - boolean
    doc: List jobs which seem to have failed to run
    default: false
    inputBinding:
      position: 102
      prefix: --failed
  - id: jobs
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict reporting to the following jobs (allows subsetting of the 
      report).
    inputBinding:
      position: 102
      prefix: --jobs
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
    doc: Turn on loglevel Warning.
    inputBinding:
      position: 102
      prefix: --logWarning
  - id: logs
    type:
      - 'null'
      - boolean
    doc: Print the log files of jobs (if they exist).
    default: false
    inputBinding:
      position: 102
      prefix: --logs
  - id: no_agg_stats
    type:
      - 'null'
      - boolean
    doc: Do not print overall, aggregate status of workflow.
    default: true
    inputBinding:
      position: 102
      prefix: --noAggStats
  - id: per_job
    type:
      - 'null'
      - boolean
    doc: Print info about each job.
    default: false
    inputBinding:
      position: 102
      prefix: --perJob
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
  - id: status
    type:
      - 'null'
      - boolean
    doc: Determine which jobs are currently running and the associated batch 
      system ID
    default: false
    inputBinding:
      position: 102
      prefix: --status
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created.
    default: /tmp
    inputBinding:
      position: 102
      prefix: --tempDirRoot
outputs:
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
