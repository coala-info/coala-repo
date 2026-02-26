cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsrq worker
label: rsrq_worker
doc: "Spawns worker processes to consume jobs from a queue\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: queue
    type: string
    doc: The target queue to process
    inputBinding:
      position: 1
  - id: burst
    type:
      - 'null'
      - boolean
    doc: Stop processing once the queue is empty
    inputBinding:
      position: 102
      prefix: --burst
  - id: max_duration
    type:
      - 'null'
      - string
    doc: 'Stop processing after (h)ours (m)inutes (s)econds (eg: 1h30m, 30m, 1h5s)'
    inputBinding:
      position: 102
      prefix: --max-duration
  - id: max_jobs
    type:
      - 'null'
      - int
    doc: Stop processing after this many jobs have finished
    inputBinding:
      position: 102
      prefix: --max-jobs
  - id: poll
    type:
      - 'null'
      - int
    doc: Interval to check for new jobs in milliseconds
    default: 1000
    inputBinding:
      position: 102
      prefix: --poll
  - id: workers
    type:
      - 'null'
      - int
    doc: The number of workers to spawn
    default: 1
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_worker.out
