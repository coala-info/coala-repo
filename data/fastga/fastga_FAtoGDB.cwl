cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastga_FAtoGDB
label: fastga_FAtoGDB
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime error messages regarding a lack of disk
  space.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_FAtoGDB.out
