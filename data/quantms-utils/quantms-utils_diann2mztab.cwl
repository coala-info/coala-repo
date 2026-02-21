cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantms-utils
  - diann2mztab
label: quantms-utils_diann2mztab
doc: "A tool within the quantms-utils suite, likely used for converting DIANN output
  to mzTab format.\n\nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_diann2mztab.out
