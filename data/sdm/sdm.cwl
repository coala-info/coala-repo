cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdm
label: sdm
doc: "sdm (simple demultiplexer) is a fast, memory efficient program to demultiplex
  fasta and fastq files or simply do quality filterings on these.\n\nTool homepage:
  https://github.com/hildebra/sdm/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdm:3.11--h077b44d_0
stdout: sdm.out
