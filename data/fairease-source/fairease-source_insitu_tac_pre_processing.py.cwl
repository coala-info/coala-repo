cwlVersion: v1.2
class: CommandLineTool
baseCommand: fairease-source_insitu_tac_pre_processing.py
label: fairease-source_insitu_tac_pre_processing.py
doc: "Pre-processing script for in-situ TAC data (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/fair-ease/Source"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fairease-source:1.4.6--pyhdfd78af_0
stdout: fairease-source_insitu_tac_pre_processing.py.out
