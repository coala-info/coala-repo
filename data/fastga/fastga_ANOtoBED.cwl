cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_ANOtoBED
label: fastga_ANOtoBED
doc: "A tool to convert ANO files to BED format (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ANOtoBED.out
