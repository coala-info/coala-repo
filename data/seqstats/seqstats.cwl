cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqstats
label: seqstats
doc: "Calculate statistics for FASTA or FASTQ files\n\nTool homepage: https://github.com/clwgg/seqstats"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqstats:1.0.0--h577a1d6_5
stdout: seqstats.out
