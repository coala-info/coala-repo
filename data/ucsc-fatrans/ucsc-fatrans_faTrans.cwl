cwlVersion: v1.2
class: CommandLineTool
baseCommand: faTrans
label: ucsc-fatrans_faTrans
doc: "Translate DNA sequences in a FASTA file to protein sequences.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatrans:482--h0b57e2e_0
stdout: ucsc-fatrans_faTrans.out
