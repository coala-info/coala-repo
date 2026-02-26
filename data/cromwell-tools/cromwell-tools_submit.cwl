cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell-tools submit
label: cromwell-tools_submit
doc: "Submit a WDL workflow on Cromwell.\n\nTool homepage: http://github.com/broadinstitute/cromwell-tools"
inputs:
  - id: collection_name
    type:
      - 'null'
      - string
    doc: Collection in SAM that the workflow should belong to, if use CaaS.
    inputBinding:
      position: 101
      prefix: --collection-name
  - id: dependencies
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the Zip file containing dependencies, or a list of raw 
      dependency files to be zipped together separated by space.
    inputBinding:
      position: 101
      prefix: --deps-file
  - id: inputs_files
    type:
      type: array
      items: File
    doc: Path(s) to the input file(s) containing input data in JSON format, 
      separated by space.
    inputBinding:
      position: 101
      prefix: --inputs-files
  - id: label_file
    type:
      - 'null'
      - File
    doc: Path to the JSON file containing a collection of key/value pairs for 
      workflow labels.
    inputBinding:
      position: 101
      prefix: --label-file
  - id: on_hold
    type:
      - 'null'
      - boolean
    doc: Whether to submit the workflow in "On Hold" status.
    inputBinding:
      position: 101
      prefix: --on-hold
  - id: options_file
    type:
      - 'null'
      - File
    doc: Path to the Cromwell configs JSON file.
    inputBinding:
      position: 101
      prefix: --options-file
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
  - id: validate_labels
    type:
      - 'null'
      - boolean
    doc: Whether to validate cromwell labels.
    inputBinding:
      position: 101
      prefix: --validate-labels
  - id: wdl_file
    type: File
    doc: Path to the workflow source file to submit for execution.
    inputBinding:
      position: 101
      prefix: --wdl-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
stdout: cromwell-tools_submit.out
