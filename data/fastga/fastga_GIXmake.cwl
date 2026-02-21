cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_GIXmake
label: fastga_GIXmake
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXmake.out
