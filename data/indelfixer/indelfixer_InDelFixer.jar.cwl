cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelfixer
label: indelfixer_InDelFixer.jar
doc: "InDelFixer is a tool for fixing insertions and deletions (InDels) in sequencing
  data. (Note: The provided help text contains only container runtime error messages
  and does not list specific command-line arguments).\n\nTool homepage: https://github.com/cbg-ethz/InDelFixer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/indelfixer:1.1--0
stdout: indelfixer_InDelFixer.jar.out
