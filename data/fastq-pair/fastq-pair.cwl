cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_pair
label: fastq-pair
doc: "A tool to rewrite paired-end FASTQ files so that the reads match up and are
  in the same order in both files.\n\nTool homepage: https://github.com/linsalrob/fastq-pair"
inputs:
  - id: fastq_1
    type: File
    doc: First FASTQ file (usually R1)
    inputBinding:
      position: 1
  - id: fastq_2
    type: File
    doc: Second FASTQ file (usually R2)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-pair:1.0--h87f3376_3
stdout: fastq-pair.out
