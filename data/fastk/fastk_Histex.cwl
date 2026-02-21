cwlVersion: v1.2
class: CommandLineTool
baseCommand: Histex
label: fastk_Histex
doc: "The provided text does not contain help information for fastk_Histex; it contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_0
stdout: fastk_Histex.out
