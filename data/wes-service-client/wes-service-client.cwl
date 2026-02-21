cwlVersion: v1.2
class: CommandLineTool
baseCommand: wes-service-client
label: wes-service-client
doc: "A client for the GA4GH Workflow Execution Service (WES) API.\n\nTool homepage:
  https://github.com/common-workflow-language/workflow-service"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wes-service-client:2.7--py_1
stdout: wes-service-client.out
