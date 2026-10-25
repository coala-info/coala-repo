cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmFaDups
label: ucsc-rmfadups
doc: "Remove duplicate records in FA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output FASTA file with duplicate records removed
    inputBinding:
      position: 2
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file with duplicates removed
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rmfadups:482--h0b57e2e_0
