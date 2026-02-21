cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - bam-extract
label: dr-disco_bam-extract
doc: "A tool for extracting data from BAM files (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
stdout: dr-disco_bam-extract.out
