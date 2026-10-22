cwlVersion: v1.2
class: CommandLineTool
baseCommand: hits_to_fastq
label: seer_hits_to_fastq
doc: "Creates a fastq for mapping from significant kmers\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: kmers
    type: File
    doc: "Significant kmers, as output by seer"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: bonf
    type: string
    doc: "Bonferroni correction to use (try 10e-8)"
    inputBinding:
      position: 1
      prefix: --bonf
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_hits_to_fastq.out
