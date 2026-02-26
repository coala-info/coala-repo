cwlVersion: v1.2
class: CommandLineTool
baseCommand: wes-client
label: wes-service-client_wes-client
doc: "Workflow Execution Service\n\nTool homepage: https://github.com/common-workflow-language/workflow-service"
inputs:
  - id: workflow_url
    type:
      - 'null'
      - string
    inputBinding:
      position: 1
  - id: job_order
    type:
      - 'null'
      - string
    inputBinding:
      position: 2
  - id: attachments
    type:
      - 'null'
      - type: array
        items: string
    doc: "A comma separated list of attachments to include.\n                    \
      \    Example: --attachments=\"testdata/dockstore-tool-\n                   \
      \     md5sum.cwl,testdata/md5sum.input\""
    inputBinding:
      position: 103
      prefix: --attachments
  - id: auth
    type:
      - 'null'
      - string
    doc: Defaults to WES_API_AUTH.
    inputBinding:
      position: 103
      prefix: --auth
  - id: get
    type:
      - 'null'
      - string
    doc: "Specify a <workflow-id>. Example: '--get=<workflow-\n                  \
      \      id>'"
    inputBinding:
      position: 103
      prefix: --get
  - id: host
    type:
      - 'null'
      - string
    doc: "Example: '--host=localhost:8080'. Defaults to WES_API_HOST."
    inputBinding:
      position: 103
      prefix: --host
  - id: info
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --info
  - id: list
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --list
  - id: log
    type:
      - 'null'
      - string
    doc: "Specify a <workflow-id>. Example: '--log=<workflow-\n                  \
      \      id>'"
    inputBinding:
      position: 103
      prefix: --log
  - id: no_wait
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --no-wait
  - id: outdir
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 103
      prefix: --outdir
  - id: page
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --page
  - id: page_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 103
      prefix: --page-size
  - id: proto
    type:
      - 'null'
      - string
    doc: 'Options: [http, https]. Defaults to WES_API_PROTO (https).'
    inputBinding:
      position: 103
      prefix: --proto
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --quiet
  - id: run
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --run
  - id: wait
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --wait
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wes-service-client:2.7--py_1
stdout: wes-service-client_wes-client.out
