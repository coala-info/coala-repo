cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-anonymous
label: fastq-anonymous
doc: "A tool for anonymizing FASTQ files by removing or replacing identifying information
  in the headers.\n\nTool homepage: https://github.com/wdecoster/fastq-anonymous"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-anonymous:1.0.1--py36_0
stdout: fastq-anonymous.out
