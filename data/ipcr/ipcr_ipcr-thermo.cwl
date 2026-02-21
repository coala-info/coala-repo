cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipcr-thermo
label: ipcr_ipcr-thermo
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains log messages and a fatal error regarding a container runtime
  (Apptainer/Singularity) failing to build a SIF image due to insufficient disk space.\n
  \nTool homepage: https://github.com/KPU-AGC/ipcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
stdout: ipcr_ipcr-thermo.out
