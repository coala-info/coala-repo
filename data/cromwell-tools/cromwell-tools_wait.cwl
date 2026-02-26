cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell-tools wait
label: cromwell-tools_wait
doc: "Wait for one or more running workflow to finish.\n\nTool homepage: http://github.com/broadinstitute/cromwell-tools"
inputs:
  - id: workflow_ids
    type:
      type: array
      items: string
    doc: Workflow IDs to wait for
    inputBinding:
      position: 1
  - id: password
    type:
      - 'null'
      - string
    doc: Cromwell password for HTTPBasicAuth.
    inputBinding:
      position: 102
      prefix: --password
  - id: poll_interval_seconds
    type:
      - 'null'
      - int
    doc: seconds between polling cromwell for workflow status.
    inputBinding:
      position: 102
      prefix: --poll-interval-seconds
  - id: secrets_file
    type:
      - 'null'
      - File
    doc: Path to the JSON file containing username, password, and url fields.
    inputBinding:
      position: 102
      prefix: --secrets-file
  - id: service_account_key
    type:
      - 'null'
      - File
    doc: Path to the JSON key file for authenticating with CaaS.
    inputBinding:
      position: 102
      prefix: --service-account-key
  - id: silent
    type:
      - 'null'
      - boolean
    doc: whether to silently print verbose workflow information while polling 
      cromwell.
    inputBinding:
      position: 102
      prefix: --silent
  - id: timeout_minutes
    type:
      - 'null'
      - int
    doc: number of minutes to wait before timeout.
    inputBinding:
      position: 102
      prefix: --timeout-minutes
  - id: url
    type:
      - 'null'
      - string
    doc: The URL to the Cromwell server. e.g. "https://cromwell.server.org/"
    inputBinding:
      position: 102
      prefix: --url
  - id: username
    type:
      - 'null'
      - string
    doc: Cromwell username for HTTPBasicAuth.
    inputBinding:
      position: 102
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
stdout: cromwell-tools_wait.out
