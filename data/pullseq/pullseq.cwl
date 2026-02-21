cwlVersion: v1.2
class: CommandLineTool
baseCommand: pullseq
label: pullseq
doc: "A tool for extracting sequences from FASTA/FASTQ files.\n\nTool homepage: https://github.com/bcthomas/pullseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pullseq:1.0.2--h1104d80_11
stdout: pullseq.out
