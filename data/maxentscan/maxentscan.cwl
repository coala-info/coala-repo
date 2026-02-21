cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxentscan
label: maxentscan
doc: "MaxEntScan is a tool for scoring splice sites. (Note: The provided input text
  contains container runtime error messages rather than the tool's help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/esebesty/maxentscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxentscan:0_2004.04.21--pl526_1
stdout: maxentscan.out
