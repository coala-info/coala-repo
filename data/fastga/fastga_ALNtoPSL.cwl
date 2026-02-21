cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_ALNtoPSL
label: fastga_ALNtoPSL
doc: "A tool to convert ALN alignment files to PSL format. (Note: The provided help
  text contains only container execution errors and does not list specific arguments.)\n
  \nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNtoPSL.out
