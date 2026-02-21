cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_ALNtoPAF
label: fastga_ALNtoPAF
doc: "A tool to convert ALN alignment files to PAF (Pairwise Mapping Format). Note:
  The provided help text contained only system error messages regarding container
  execution and did not list specific command-line arguments.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNtoPAF.out
