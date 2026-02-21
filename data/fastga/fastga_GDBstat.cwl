cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_GDBstat
label: fastga_GDBstat
doc: "A tool within the fastga package. (Note: The provided help text contains only
  container runtime error messages and does not list usage instructions or arguments.)\n
  \nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GDBstat.out
