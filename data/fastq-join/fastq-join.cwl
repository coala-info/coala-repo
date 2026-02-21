cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-join
label: fastq-join
doc: "The provided text contains a system error message (no space left on device)
  and does not contain the help documentation for fastq-join. Based on standard fastq-join
  usage, it joins two paired-end reads on the overlapping ends.\n\nTool homepage:
  https://github.com/movingpictures83/FastQJoin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-join:1.3.1--h9f5acd7_5
stdout: fastq-join.out
