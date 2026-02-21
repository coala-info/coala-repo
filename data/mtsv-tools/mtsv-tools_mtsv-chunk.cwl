cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-chunk
label: mtsv-tools_mtsv-chunk
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.0.2--h7b50bb2_4
stdout: mtsv-tools_mtsv-chunk.out
