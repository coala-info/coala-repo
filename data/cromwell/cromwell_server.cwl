cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell
label: cromwell_server
doc: "Cromwell - Workflow Execution Engine\n\nTool homepage: https://github.com/broadinstitute/cromwell"
inputs:
  - id: command
    type: string
    doc: Command to execute (server, run, submit)
    inputBinding:
      position: 1
  - id: workflow_source
    type: string
    doc: Workflow source file or workflow url
    inputBinding:
      position: 2
  - id: host
    type:
      - 'null'
      - string
    doc: Cromwell server URL
    inputBinding:
      position: 103
      prefix: --host
  - id: imports
    type:
      - 'null'
      - string
    doc: A directory or zipfile to search for workflow imports
    inputBinding:
      position: 103
      prefix: --imports
  - id: inputs
    type:
      - 'null'
      - File
    doc: Workflow inputs file
    inputBinding:
      position: 103
      prefix: --inputs
  - id: labels
    type:
      - 'null'
      - File
    doc: Workflow labels file
    inputBinding:
      position: 103
      prefix: --labels
  - id: options
    type:
      - 'null'
      - File
    doc: Workflow options file
    inputBinding:
      position: 103
      prefix: --options
  - id: type
    type:
      - 'null'
      - string
    doc: Workflow type
    inputBinding:
      position: 103
      prefix: --type
  - id: type_version
    type:
      - 'null'
      - string
    doc: Workflow type version
    inputBinding:
      position: 103
      prefix: --type-version
  - id: workflow_root
    type:
      - 'null'
      - string
    doc: Workflow root
    inputBinding:
      position: 103
      prefix: --workflow-root
outputs:
  - id: metadata_output
    type:
      - 'null'
      - Directory
    doc: An optional directory path to output metadata
    outputBinding:
      glob: $(inputs.metadata_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell:0.40--1
