cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastuniq
label: fastuniq
doc: "A tool for removing duplicate reads from paired-end or single-end FASTQ files.\n
  \nTool homepage: https://github.com/matsuoka-601/FastUniq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastuniq:1.1--h7b50bb2_2
stdout: fastuniq.out
