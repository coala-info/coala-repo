cwlVersion: v1.2
class: CommandLineTool
baseCommand: multitax
label: multitax
doc: "A tool for handling and translating taxonomic identifiers.\n\nTool homepage:
  https://github.com/pirovc/multitax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multitax:1.3.2--pyhdfd78af_0
stdout: multitax.out
