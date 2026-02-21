cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToFastq
label: ucsc-fatofastq
doc: "Convert FASTA format files to FASTQ format. (Note: The provided help text contained
  a fatal container error and did not list specific arguments.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatofastq:482--h0b57e2e_0
stdout: ucsc-fatofastq.out
