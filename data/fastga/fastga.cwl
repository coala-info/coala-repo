cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga
label: fastga
doc: "Fast Genetic Algorithm tool (Note: The provided help text contains only container
  runtime errors and no usage information).\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga.out
