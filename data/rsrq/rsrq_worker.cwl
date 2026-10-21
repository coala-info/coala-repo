cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsrq
  - worker
label: rsrq_worker
doc: "Spawns worker processes to consume jobs from a queue\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: redis_url
    type: string
    doc: URL of the Redis server (set as the REDIS_URL environment variable), for example redis://localhost:6379
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
    inputBinding:
      position: 102
      prefix: --poll
  - id: workers
    type:
      - 'null'
      - int
    doc: The number of workers to spawn
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages (rsrq writes its results to standard error)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: REDIS_URL
        envValue: $(inputs.redis_url)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_worker.out
stderr: rsrq_worker.err
