cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell-tools query
label: cromwell-tools_query
doc: "Query for workflows.\n\nTool homepage: http://github.com/broadinstitute/cromwell-tools"
inputs:
  - id: password
    type:
      - 'null'
      - string
    doc: Cromwell password for HTTPBasicAuth.
    inputBinding:
      position: 101
      prefix: --password
  - id: secrets_file
    type:
      - 'null'
      - File
    doc: Path to the JSON file containing username, password, and url fields.
    inputBinding:
      position: 101
      prefix: --secrets-file
  - id: service_account_key
    type:
      - 'null'
      - File
    doc: Path to the JSON key file for authenticating with CaaS.
    inputBinding:
      position: 101
      prefix: --service-account-key
  - id: url
    type:
      - 'null'
      - string
    doc: The URL to the Cromwell server. e.g. "https://cromwell.server.org/"
    inputBinding:
      position: 101
      prefix: --url
  - id: username
    type:
      - 'null'
      - string
    doc: Cromwell username for HTTPBasicAuth.
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
stdout: cromwell-tools_query.out
