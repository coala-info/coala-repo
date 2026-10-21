cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsrq
  - purge
  - all
label: rsrq_purge_all
doc: "Removes all data from Redis\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: redis_url
    type: string
    doc: URL of the Redis server (set as the REDIS_URL environment variable), for example redis://localhost:6379
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages (rsrq writes its results to standard error)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: REDIS_URL
        envValue: $(inputs.redis_url)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_purge_all.out
stderr: rsrq_purge_all.err
