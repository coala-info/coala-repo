cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromimpute
label: chromimpute
doc: "ChromImpute is a tool for systematic epigenomic data imputation. (Note: The
  provided help text appears to be a container runtime error log and does not contain
  command-line usage information.)\n\nTool homepage: https://github.com/jernst98/ChromImpute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromimpute:1.0.3--h05cac1d_2
stdout: chromimpute.out
