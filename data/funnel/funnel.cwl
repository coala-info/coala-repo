cwlVersion: v1.2
class: CommandLineTool
baseCommand: funnel
label: funnel
doc: "Funnel is a toolkit for distributed task execution, implementing the GA4GH Task
  Execution Service (TES) API.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel.out
