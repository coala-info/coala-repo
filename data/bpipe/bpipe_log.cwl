cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe_log
label: bpipe_log
doc: "Show log output from bpipe jobs\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: jobid
    type:
      - 'null'
      - string
    doc: Job ID to show output for
    inputBinding:
      position: 1
  - id: command_id
    type:
      - 'null'
      - string
    doc: command id to show output for
    inputBinding:
      position: 102
      prefix: --command
  - id: completed_pid
    type:
      - 'null'
      - string
    doc: show in context of completed pipeline with given pid
    inputBinding:
      position: 102
      prefix: --completed
  - id: follow
    type:
      - 'null'
      - boolean
    doc: keep following file until user presses Ctrl+C
    inputBinding:
      position: 102
      prefix: --follow
  - id: lines
    type:
      - 'null'
      - int
    doc: number of lines to log
    inputBinding:
      position: 102
      prefix: --lines
  - id: show_errors
    type:
      - 'null'
      - boolean
    doc: show output for commands that failed in the last run
    inputBinding:
      position: 102
      prefix: --errors
  - id: stage_id
    type:
      - 'null'
      - string
    doc: stage id to show output for
    inputBinding:
      position: 102
      prefix: --stageid
  - id: thread_id
    type:
      - 'null'
      - int
    doc: thread id to track
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose logging
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_log.out
