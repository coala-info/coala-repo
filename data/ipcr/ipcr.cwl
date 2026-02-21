cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipcr
label: ipcr
doc: "The provided text does not contain help documentation for the 'ipcr' tool. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/KPU-AGC/ipcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
stdout: ipcr.out
