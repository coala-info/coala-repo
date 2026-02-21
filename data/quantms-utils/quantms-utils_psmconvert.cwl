cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantms-utils_psmconvert
label: quantms-utils_psmconvert
doc: "A utility from the quantms-utils package (Note: The provided input text contains
  system error logs rather than command-line help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_psmconvert.out
