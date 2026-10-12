cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parasail_stats
label: parasail_parasail_stats
doc: "Report simple statistics (sequence count, character count, shortest, longest,
  mean and standard deviation of sequence length) of a FASTA file.\n\nTool homepage:
  https://github.com/jeffdaily/parasail"
inputs:
  - id: file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parasail:2.6.2--h5ca1c30_1
stdout: parasail_parasail_stats.out
