cwlVersion: v1.2
class: CommandLineTool
baseCommand: riborex
label: riborex
doc: "The provided text contains container engine error logs rather than the tool's
  help documentation. As a result, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/smithlabcode/riborex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riborex:2.4.0--r341_0
stdout: riborex.out
