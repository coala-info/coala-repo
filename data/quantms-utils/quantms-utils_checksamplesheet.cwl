cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantms-utils
  - checksamplesheet
label: quantms-utils_checksamplesheet
doc: "A utility to check and validate sample sheets for the quantms pipeline. (Note:
  The provided text contains container execution errors and does not list specific
  arguments.)\n\nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_checksamplesheet.out
