cwlVersion: v1.2
class: CommandLineTool
baseCommand: crunchstat-summary
label: crunchstat-summary
doc: "Summarize resource usage of an Arvados Crunch job\n\nTool homepage: https://arvados.org"
inputs:
  - id: job
    type:
      - 'null'
      - string
    doc: Look up the specified job or container request (UUID) and read its log
      data from Keep (or from the Arvados event log, if the job is still running).
      Needs access to an Arvados cluster.
    inputBinding:
      position: 101
      prefix: --job
  - id: container
    type:
      - 'null'
      - string
    doc: '[Deprecated] Look up the specified container (UUID), find its container
      request and read its log data from Keep. Needs access to an Arvados cluster.'
    inputBinding:
      position: 101
      prefix: --container
  - id: log_file
    type:
      - 'null'
      - File
    doc: Read log data from a regular file
    inputBinding:
      position: 101
      prefix: --log-file
  - id: skip_child_jobs
    type:
      - 'null'
      - boolean
    doc: Do not include stats from child jobs/containers
    inputBinding:
      position: 101
      prefix: --skip-child-jobs
  - id: format
    type:
      - 'null'
      - type: enum
        symbols:
          - html
          - text
    doc: Report format
    inputBinding:
      position: 101
      prefix: --format
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum worker threads to run
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Log more information (once for progress, twice for debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: arvados_api_host
    type:
      - 'null'
      - string
    doc: Arvados API host (sets ARVADOS_API_HOST). The tool connects to the Arvados
      API on every run, also when it reads a local log file.
  - id: arvados_api_token
    type:
      - 'null'
      - string
    doc: Arvados API token (sets ARVADOS_API_TOKEN).
  - id: out_path
    type: string
    default: crunchstat-summary.report
    doc: Name of the file that receives the report (written to standard output)
outputs:
  - id: out
    type: stdout
    doc: Resource usage report (text or html)
stdout: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      ARVADOS_API_HOST: '$(inputs.arvados_api_host ? inputs.arvados_api_host : "")'
      ARVADOS_API_TOKEN: '$(inputs.arvados_api_token ? inputs.arvados_api_token : "")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crunchstat-summary:3.2.0--pyhdfd78af_0
