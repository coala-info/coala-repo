cwlVersion: v1.2
class: CommandLineTool
baseCommand: funnel storage
label: funnel_storage
doc: "Access storage via Funnel's client libraries.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Config File
    inputBinding:
      position: 101
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_storage.out
