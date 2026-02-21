cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkAgpAndFa
label: ucsc-checkagpandfa
doc: "Check that an AGP file and a FASTA file are consistent.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: agp_file
    type: File
    doc: The AGP file to check.
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: The FASTA file to check against the AGP file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checkagpandfa:482--h0b57e2e_0
stdout: ucsc-checkagpandfa.out
