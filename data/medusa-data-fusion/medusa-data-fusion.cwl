cwlVersion: v1.2
class: CommandLineTool
baseCommand: medusa-data-fusion
label: medusa-data-fusion
doc: 'A tool for data fusion (Note: The provided help text contains only system error
  messages and no usage information).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medusa-data-fusion:0.1--py27h24bf2e0_2
stdout: medusa-data-fusion.out
