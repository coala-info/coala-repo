cwlVersion: v1.2
class: CommandLineTool
baseCommand: captus
label: captus
doc: "Captus is a tool for assembly and analysis of phylogenomic data (Note: The provided
  text contains only system error logs and no help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://github.com/edgardomortiz/Captus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/captus:1.6.1--pyh05cac1d_0
stdout: captus.out
