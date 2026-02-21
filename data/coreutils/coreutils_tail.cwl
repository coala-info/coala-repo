cwlVersion: v1.2
class: CommandLineTool
baseCommand: tail
label: coreutils_tail
doc: "Print the last 10 lines of each FILE to standard output. With more than one
  FILE, precede each with a header giving the file name.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to output the last lines of. With no FILE, or when FILE is -, read
      standard input.
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - string
    doc: output the last NUM bytes; or use -c +NUM to output starting with byte NUM
      of each file
    inputBinding:
      position: 102
      prefix: --bytes
  - id: follow
    type:
      - 'null'
      - string
    doc: output appended data as the file grows; an absent option argument means 'descriptor'
    inputBinding:
      position: 102
      prefix: --follow
  - id: follow_retry
    type:
      - 'null'
      - boolean
    doc: same as --follow=name --retry
    inputBinding:
      position: 102
      prefix: -F
  - id: lines
    type:
      - 'null'
      - string
    doc: output the last NUM lines, instead of the last 10; or use -n +NUM to skip
      NUM-1 lines at the start
    inputBinding:
      position: 102
      prefix: --lines
  - id: max_unchanged_stats
    type:
      - 'null'
      - int
    doc: with --follow=name, reopen a FILE which has not changed size after N (default
      5) iterations to see if it has been unlinked or renamed
    default: 5
    inputBinding:
      position: 102
      prefix: --max-unchanged-stats
  - id: pid
    type:
      - 'null'
      - type: array
        items: int
    doc: with -f, terminate after process ID, PID dies; can be repeated to watch multiple
      processes
    inputBinding:
      position: 102
      prefix: --pid
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: never output headers giving file names
    inputBinding:
      position: 102
      prefix: --quiet
  - id: retry
    type:
      - 'null'
      - boolean
    doc: keep trying to open a file if it is inaccessible
    inputBinding:
      position: 102
      prefix: --retry
  - id: sleep_interval
    type:
      - 'null'
      - float
    doc: with -f, sleep for approximately N seconds (default 1.0) between iterations
    default: 1.0
    inputBinding:
      position: 102
      prefix: --sleep-interval
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: always output headers giving file names
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: line delimiter is NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero-terminated
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_tail.out
