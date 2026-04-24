cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - debug-file
label: toil_debug-file
doc: "Debug and manage files within a Toil job store.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: string
    doc: The location of the job store for the workflow. A job store holds 
      persistent information about the jobs, stats, and files in a workflow.
    inputBinding:
      position: 1
  - id: fetch
    type:
      - 'null'
      - type: array
        items: string
    doc: List of job-store files to be copied locally. Use either explicit names
      or glob patterns.
    inputBinding:
      position: 102
      prefix: --fetch
  - id: list_files_in_job_store
    type:
      - 'null'
      - string
    doc: Prints a list of the current files in the jobStore.
    inputBinding:
      position: 102
      prefix: --listFilesInJobStore
  - id: local_file_path
    type:
      - 'null'
      - Directory
    doc: Location to which to copy job store files.
    inputBinding:
      position: 102
      prefix: --localFilePath
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
    doc: 'Set the log level. Options: Critical, Error, Warning, Debug, Info, etc.'
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
      created.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
  - id: use_symlinks
    type:
      - 'null'
      - string
    doc: Creates symlink 'shortcuts' of files in the localFilePath instead of 
      hardlinking or copying.
    inputBinding:
      position: 102
      prefix: --useSymlinks
outputs:
  - id: fetch_entire_job_store
    type:
      - 'null'
      - Directory
    doc: Copy all job store files into a local directory.
    outputBinding:
      glob: $(inputs.fetch_entire_job_store)
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
