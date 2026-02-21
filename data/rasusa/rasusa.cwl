cwlVersion: v1.2
class: CommandLineTool
baseCommand: rasusa
label: rasusa
doc: "Randomly subsample sequencing reads to a specific coverage.\n\nTool homepage:
  https://github.com/mbhall88/rasusa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rasusa:2.2.2--hc1c3326_0
stdout: rasusa.out
