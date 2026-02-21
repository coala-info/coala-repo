cwlVersion: v1.2
class: CommandLineTool
baseCommand: psm-utils
label: psm-utils
doc: "The provided text is a container build log and does not contain CLI help information
  or argument definitions. As a result, no arguments could be extracted.\n\nTool homepage:
  https://github.com/compomics/psm_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psm-utils:1.5.1--pyhdfd78af_0
stdout: psm-utils.out
