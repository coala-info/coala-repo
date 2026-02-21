cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvest-tools
label: harvest-tools
doc: "A tool for harvesting and manipulating genomic data (Note: The provided text
  contains system error messages rather than help documentation).\n\nTool homepage:
  https://github.com/lanmaster53/recon-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/harvest-tools:v1.3-4-deb_cv1
stdout: harvest-tools.out
