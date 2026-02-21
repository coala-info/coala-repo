cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga
label: fastga_GIXmv
doc: "FastGA is a tool for fast genome alignment. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXmv.out
