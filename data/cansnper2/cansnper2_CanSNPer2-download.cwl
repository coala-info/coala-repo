cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer2-download
label: cansnper2_CanSNPer2-download
doc: "Download script for CanSNPer2 (Note: The provided help text contains system
  error logs rather than command usage information).\n\nTool homepage: https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
stdout: cansnper2_CanSNPer2-download.out
