cwlVersion: v1.2
class: CommandLineTool
baseCommand: fissfc
label: firecloud_fissfc
doc: "FireCloud Service Selector (FISS) CLI. Note: The provided input text contains
  system error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/broadinstitute/fiss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/firecloud:0.16.38--pyhdfd78af_0
stdout: firecloud_fissfc.out
