cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-build
label: mtsv-tools_mtsv-build
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to insufficient disk space.\n\n
  Tool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.0.2--h7b50bb2_4
stdout: mtsv-tools_mtsv-build.out
