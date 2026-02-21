cwlVersion: v1.2
class: CommandLineTool
baseCommand: clark
label: clark
doc: "CLARK (Classifier based on Reduced K-mers) is a tool for the classification
  of metagenomic sequences. Note: The provided text contains system error logs rather
  than tool help documentation.\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark.out
