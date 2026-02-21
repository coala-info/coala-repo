cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-tools
label: mtsv-tools
doc: "Metagenomics Analysis Pipeline tools (Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.0.2--h7b50bb2_4
stdout: mtsv-tools.out
