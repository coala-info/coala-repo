cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consensus
label: ra_consensus
doc: "Builds consensus sequences (transcripts) from a FASTA reads file and AFG contigs;\
  \ FASTA written to standard output.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: reads
    type: File
    doc: reads file (FASTA)
    inputBinding:
      position: 1
      prefix: --reads
  - id: contigs
    type: File
    doc: contigs file (AFG)
    inputBinding:
      position: 2
      prefix: --contigs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_consensus.out
