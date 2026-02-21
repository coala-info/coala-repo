cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnachisel
label: dnachisel
doc: "A Python library and CLI tool for DNA sequence optimization (Note: The provided
  text contains only system error logs and no help documentation to parse).\n\nTool
  homepage: https://github.com/Edinburgh-Genome-Foundry/DnaChisel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnachisel:3.2.16--pyh7e72e81_0
stdout: dnachisel.out
