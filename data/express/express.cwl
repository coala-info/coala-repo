cwlVersion: v1.2
class: CommandLineTool
baseCommand: express
label: express
doc: "Streaming quantification for high-throughput sequencing\n\nTool homepage: https://github.com/expressjs/express"
inputs:
  - id: target_fasta
    type: File
    doc: Target sequence fasta file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/express:1.5.1--h2d50403_1
stdout: express.out
