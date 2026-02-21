cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga
label: fastga_GIXcp
doc: "Fast Genome Alignment tool (Note: The provided text is an error log regarding
  container image conversion and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXcp.out
