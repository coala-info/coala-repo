cwlVersion: v1.2
class: CommandLineTool
baseCommand: blockbuster
label: blockbuster
doc: "A tool for detecting blocks of reads from short-read sequencing data (e.g.,
  for identifying small RNA clusters).\n\nTool homepage: https://github.com/rfinnie/blockbuster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockbuster:0.0.1.1--h7b50bb2_8
stdout: blockbuster.out
