cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_ALNshow
label: fastga_ALNshow
doc: "A tool within the fastga package. (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific arguments
  or usage instructions.)\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNshow.out
