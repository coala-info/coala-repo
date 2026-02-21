cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantms-utils_dianncfg
label: quantms-utils_dianncfg
doc: "The provided text does not contain help information; it is a container execution
  error log.\n\nTool homepage: https://www.github.com/bigbio/quantms-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantms-utils:0.0.24--pyh7e72e81_0
stdout: quantms-utils_dianncfg.out
