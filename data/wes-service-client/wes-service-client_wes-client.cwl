cwlVersion: v1.2
class: CommandLineTool
baseCommand: wes-client
label: wes-service-client_wes-client
doc: "Workflow Execution Service (WES) client for interacting with WES servers.\n\n
  Tool homepage: https://github.com/common-workflow-language/workflow-service"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wes-service-client:2.7--py_1
stdout: wes-service-client_wes-client.out
