cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - gce
label: funnel_gce
doc: "Manage GCE resources for funnel\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: run'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_gce.out
