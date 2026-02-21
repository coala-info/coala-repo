cwlVersion: v1.2
class: CommandLineTool
baseCommand: asgal
label: asgal
doc: "ASGAL (Alternative Splicing Graph ALigner) is a tool for aligning RNA-Seq reads
  to a gene graph to detect alternative splicing events.\n\nTool homepage: https://asgal.algolab.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
stdout: asgal.out
