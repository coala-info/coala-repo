cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantms-utils
  - mzmlstats
label: quantms-utils_mzmlstats
doc: "A utility for generating statistics from mzML files. (Note: The provided help
  text contains container execution errors and does not list specific arguments.)\n
  \nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_mzmlstats.out
