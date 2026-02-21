cwlVersion: v1.2
class: CommandLineTool
baseCommand: mendelscan
label: mendelscan
doc: "MendelScan is a tool for identifying causative variants in rare disease (Note:
  The provided text contains only system error logs and no help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/genome/mendelscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0
stdout: mendelscan.out
