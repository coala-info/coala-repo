cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantms-utils
  - openms2sample
label: quantms-utils_openms2sample
doc: "A utility within the quantms-utils package. (Note: The provided help text contains
  container runtime error logs and does not list specific usage instructions or arguments).\n
  \nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_openms2sample.out
