cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipcr-nested
label: ipcr_ipcr-nested
doc: "The provided text does not contain help information or usage instructions. It
  contains system logs and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/KPU-AGC/ipcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
stdout: ipcr_ipcr-nested.out
