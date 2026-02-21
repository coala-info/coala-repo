cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtsv-tools
  - mtsv-binner
label: mtsv-tools_mtsv-binner
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image extraction (no space
  left on device).\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.0.2--h7b50bb2_4
stdout: mtsv-tools_mtsv-binner.out
