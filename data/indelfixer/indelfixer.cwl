cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelfixer
label: indelfixer
doc: "IndelFixer is a tool used for fixing insertions and deletions (indels) in sequencing
  data, typically by aligning reads to a reference and identifying consistent indel
  patterns.\n\nTool homepage: https://github.com/cbg-ethz/InDelFixer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/indelfixer:1.1--0
stdout: indelfixer.out
