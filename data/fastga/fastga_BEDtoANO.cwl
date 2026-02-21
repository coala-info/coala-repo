cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_BEDtoANO
label: fastga_BEDtoANO
doc: "A tool within the fastga suite, likely used for converting BED files to ANO
  format. (Note: The provided help text contains only system error messages regarding
  container execution and does not list specific CLI arguments.)\n\nTool homepage:
  https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_BEDtoANO.out
