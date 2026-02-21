cwlVersion: v1.2
class: CommandLineTool
baseCommand: reviewer
label: reviewer
doc: "A tool for reviewing sequencing data (description not provided in help text)\n
  \nTool homepage: https://github.com/Illumina/REViewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reviewer:0.2.7--h48da230_0
stdout: reviewer.out
