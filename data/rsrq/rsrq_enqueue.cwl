cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsrq
  - enqueue
label: rsrq_enqueue
doc: "Enqueue a batch of commands to be run\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: redis_url
    type: string
    doc: URL of the Redis server (set as the REDIS_URL environment variable), for example redis://localhost:6379
  - id: queue
    type: string
    doc: The target queue to add jobs to
    inputBinding:
      position: 1
  - id: path
    type: File
    doc: Path to the file containing one command per-line
    inputBinding:
      position: 2
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
stdout: rsrq_enqueue.out
stderr: rsrq_enqueue.err
