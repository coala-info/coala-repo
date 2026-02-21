cwlVersion: v1.2
class: CommandLineTool
baseCommand: JAMM.sh
label: jamm_JAMM.sh
doc: "JAMM (Joint Analysis of peak Shapes and Methylation) is a peak finder for NGS
  data. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/mahmoudibrahim/JAMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jamm:1.0.8.0--hdfd78af_1
stdout: jamm_JAMM.sh.out
