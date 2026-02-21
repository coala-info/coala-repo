cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtsv-tools
  - mtsv-collapse
label: mtsv-tools_mtsv-collapse
doc: "The provided text contains error messages related to a container runtime (Apptainer/Singularity)
  failure and does not contain help text or usage information for the tool.\n\nTool
  homepage: https://github.com/FofanovLab/mtsv_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.0.2--h7b50bb2_4
stdout: mtsv-tools_mtsv-collapse.out
