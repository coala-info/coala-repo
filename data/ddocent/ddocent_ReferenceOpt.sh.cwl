cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddocent_ReferenceOpt.sh
label: ddocent_ReferenceOpt.sh
doc: "Reference optimization script for dDocent. Note: The provided help text contains
  only system error messages regarding container execution and does not list available
  command-line arguments.\n\nTool homepage: https://ddocent.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_ReferenceOpt.sh.out
