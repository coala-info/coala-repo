cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - dashboard
label: funnel_dashboard
doc: "Start a Funnel dashboard in your terminal.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: server
    type:
      - 'null'
      - string
    doc: The server address for the dashboard
    default: http://localhost:8000
    inputBinding:
      position: 101
      prefix: --server
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_dashboard.out
