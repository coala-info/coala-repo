cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_ANOstat
label: fastga_ANOstat
doc: "A tool for fast genome analysis (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ANOstat.out
