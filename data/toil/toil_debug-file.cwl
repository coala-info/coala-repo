cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - toil
  - debug-file
label: toil_debug-file
doc: "Debug and manage files within a Toil job store.\n\nTool homepage: https://toil.ucsc-cgl.org/"
inputs:
  - id: job_store
    type: Directory
    doc: 'The job store directory of the workflow (a file job store). A job store holds persistent information about the jobs, stats, and files in a workflow.'
    inputBinding:
      position: 1
      valueFrom: $(runtime.outdir + '/' + self.basename)
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
    doc: Prints a list of the current files in the jobStore (True or False); the list is written to jobstore_files.txt.
    inputBinding:
      position: 102
      prefix: --listFilesInJobStore
  - id: local_file_path
    type:
      - 'null'
      - string
    doc: Location (directory name) to which to copy job store files. The directory is created before the run.
    inputBinding:
      position: 102
      prefix: --localFilePath
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
      - string
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
  - id: fetch_entire_job_store
    type:
      - 'null'
      - string
    doc: 'Copy all job store files into the --localFilePath directory (True or False).'
    inputBinding:
      position: 103
      prefix: --fetchEntireJobStore
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: 'File to log in. (default: None)'
    inputBinding:
      position: 104
      prefix: --logFile
outputs:
  - id: local_files
    type:
      - 'null'
      - Directory
    doc: Directory to which job store files were copied (--localFilePath)
    outputBinding:
      glob: $(inputs.local_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: jobstore_files
    type:
      - 'null'
      - File
    doc: List of the files in the job store (written with --listFilesInJobStore)
    outputBinding:
      glob: jobstore_files.txt
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.job_store)
        writable: true
      - entry: |-
          ${ return inputs.local_file_path ? {class: 'Directory', basename: inputs.local_file_path, listing: []} : null; }
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toil:7.0.0--pyhdfd78af_0
stdout: toil_debug-file.out
