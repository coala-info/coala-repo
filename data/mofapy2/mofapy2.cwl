cwlVersion: v1.2
class: CommandLineTool
baseCommand: mofapy2
label: mofapy2
doc: "Multi-Omics Factor Analysis (MOFA+). Note: The provided text contains system
  error messages rather than tool help documentation.\n\nTool homepage: https://github.com/bioFAM/mofapy2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mofapy2:0.7.3--pyh7e72e81_0
stdout: mofapy2.out
