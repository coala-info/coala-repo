cwlVersion: v1.2
class: CommandLineTool
baseCommand: ea-utils
label: ea-utils
doc: "A suite of command-line tools for processing biological sequencing data (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils.out
