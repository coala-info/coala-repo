cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToFa
label: ucsc-pslxtofa
doc: "Convert PSL format to FASTA format using the target sequence.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: target_seq
    type: File
    doc: Target sequence file (FASTA or 2bit format)
    inputBinding:
      position: 2
outputs:
  - id: out_fa
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslxtofa:482--h0b57e2e_0
