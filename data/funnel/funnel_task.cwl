cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - task
label: funnel_task
doc: "Make API calls to a TES server.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: server
    type:
      - 'null'
      - string
    doc: TES server address
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
stdout: funnel_task.out
