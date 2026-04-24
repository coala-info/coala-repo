cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobTreeStatus
label: jobtree_jobTreeStatus
doc: "Prints the status of a job tree.\n\nTool homepage: https://github.com/benedictpaten/jobTree"
inputs:
  - id: job_tree_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the job tree. The jobTree location can also be 
      specified as the argument to the script.
    inputBinding:
      position: 1
  - id: fail_if_not_complete
    type:
      - 'null'
      - boolean
    doc: Return exit value of 1 if job tree jobs not all completed.
    inputBinding:
      position: 102
      prefix: --failIfNotComplete
  - id: job_tree
    type:
      - 'null'
      - Directory
    doc: Directory containing the job tree. The jobTree location can also be 
      specified as the argument to the script.
    inputBinding:
      position: 102
      prefix: --jobTree
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Turn on logging at DEBUG level. (default is CRITICAL)
    inputBinding:
      position: 102
      prefix: --logDebug
  - id: log_file
    type:
      - 'null'
      - File
    doc: File to log in
    inputBinding:
      position: 102
      prefix: --logFile
  - id: log_info
    type:
      - 'null'
      - boolean
    doc: Turn on logging at INFO level. (default is CRITICAL)
    inputBinding:
      position: 102
      prefix: --logInfo
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log at level (may be either OFF/INFO/DEBUG/CRITICAL).
    inputBinding:
      position: 102
      prefix: --logLevel
  - id: log_off
    type:
      - 'null'
      - boolean
    doc: Turn off logging. (default is CRITICAL)
    inputBinding:
      position: 102
      prefix: --logOff
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files getting too big.
    inputBinding:
      position: 102
      prefix: --rotatingLogging
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created, by default uses the current working directory as the base.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print loads of information, particularly all the log files of jobs that
      failed.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
stdout: jobtree_jobTreeStatus.out
