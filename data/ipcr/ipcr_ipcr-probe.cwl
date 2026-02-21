cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipcr-probe
label: ipcr_ipcr-probe
doc: "In-silico PCR tool (Note: The provided help text contains only system error
  messages and no usage information).\n\nTool homepage: https://github.com/KPU-AGC/ipcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipcr:4.1.1--he881be0_1
stdout: ipcr_ipcr-probe.out
