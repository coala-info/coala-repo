cwlVersion: v1.2
class: CommandLineTool
baseCommand: turbocor
label: turbocor
doc: "The provided text is a system error log regarding a failed container build/fetch
  process and does not contain the help documentation for the 'turbocor' tool. Consequently,
  no arguments or tool descriptions could be extracted.\n\nTool homepage: https://github.com/dcjones/turbocor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/turbocor:0.1.1--h5177ac6_0
stdout: turbocor.out
