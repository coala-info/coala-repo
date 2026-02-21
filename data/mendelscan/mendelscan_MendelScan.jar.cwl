cwlVersion: v1.2
class: CommandLineTool
baseCommand: mendelscan
label: mendelscan_MendelScan.jar
doc: "MendelScan (Note: The provided text contains system error messages regarding
  container image building and does not include tool-specific help or usage instructions.)\n
  \nTool homepage: https://github.com/genome/mendelscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0
stdout: mendelscan_MendelScan.jar.out
