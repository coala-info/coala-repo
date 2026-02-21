cwlVersion: v1.2
class: CommandLineTool
baseCommand: adapt
label: adapt
doc: "The provided text is a system error log (out of disk space during a container
  build) and does not contain the help text or usage information for the 'adapt' tool.
  Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/broadinstitute/adapt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adapt:1.6.0--pyhdfd78af_0
stdout: adapt.out
