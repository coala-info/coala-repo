cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell-tools metadata
label: cromwell-tools_metadata
doc: "Retrieve the workflow and call-level metadata for a specified workflow by UUID.\n\
  \nTool homepage: http://github.com/broadinstitute/cromwell-tools"
inputs:
  - id: exclude_key
    type:
      - 'null'
      - type: array
        items: string
    doc: When specified key(s) to exclude from the metadata. Matches any key 
      starting with the value. May not be used with includeKey.
    inputBinding:
      position: 101
      prefix: --excludeKey
  - id: expand_sub_workflows
    type:
      - 'null'
      - boolean
    doc: When true, metadata for sub workflows will be fetched and inserted 
      automatically in the metadata response.
    inputBinding:
      position: 101
      prefix: --expandSubWorkflows
  - id: include_key
    type:
      - 'null'
      - type: array
        items: string
    doc: When specified key(s) to include from the metadata. Matches any key 
      starting with the value. May not be used with excludeKey.
    inputBinding:
      position: 101
      prefix: --includeKey
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
  - id: uuid
    type: string
    doc: A Cromwell workflow UUID, which is the workflow identifier.
    inputBinding:
      position: 101
      prefix: --uuid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
stdout: cromwell-tools_metadata.out
