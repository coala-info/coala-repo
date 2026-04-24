cwlVersion: v1.2
class: CommandLineTool
baseCommand: jobTreeStats
label: jobtree_jobTreeStats
doc: "Prints statistics about a jobTree.\n\nTool homepage: https://github.com/benedictpaten/jobTree"
inputs:
  - id: job_tree_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the job tree. Can also be specified as the single 
      argument to the script.
    inputBinding:
      position: 1
  - id: cache
    type:
      - 'null'
      - boolean
    doc: stores a cache to speed up data display.
    inputBinding:
      position: 102
      prefix: --cache
  - id: categories
    type:
      - 'null'
      - string
    doc: comma separated list from [time, clock, wait, memory]
    inputBinding:
      position: 102
      prefix: --categories
  - id: human
    type:
      - 'null'
      - boolean
    doc: if not raw, prettify the numbers to be human readable.
    inputBinding:
      position: 102
      prefix: --human
  - id: job_tree
    type:
      - 'null'
      - Directory
    doc: Directory containing the job tree. Can also be specified as the single 
      argument to the script.
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
    doc: Log at level (may be either OFF/INFO/DEBUG/CRITICAL). (default is 
      CRITICAL)
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
    doc: output the raw xml data.
    inputBinding:
      position: 102
      prefix: --raw
  - id: reverse_sort
    type:
      - 'null'
      - boolean
    doc: reverse sort order.
    inputBinding:
      position: 102
      prefix: --reverseSort
  - id: rotating_logging
    type:
      - 'null'
      - boolean
    doc: Turn on rotating logging, which prevents log files getting too big.
    inputBinding:
      position: 102
      prefix: --rotatingLogging
  - id: sort_category
    type:
      - 'null'
      - string
    doc: how to sort Target list. may be from [alpha, time, clock, wait, memory,
      count]. default=%(default)s
    inputBinding:
      position: 102
      prefix: --sortCategory
  - id: sort_field
    type:
      - 'null'
      - string
    doc: how to sort Target list. may be from [min, med, ave, max, total]. 
      default=%(default)s
    inputBinding:
      position: 102
      prefix: --sortField
  - id: sort_reverse
    type:
      - 'null'
      - boolean
    doc: reverse sort order.
    inputBinding:
      position: 102
      prefix: --sortReverse
  - id: temp_dir_root
    type:
      - 'null'
      - Directory
    doc: Path to where temporary directory containing all temp files are 
      created, by default uses the current working directory as the base.
    inputBinding:
      position: 102
      prefix: --tempDirRoot
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File in which to write results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jobtree:09.04.2017--py_2
