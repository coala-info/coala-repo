cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopFaLines
label: ucsc-chopfalines
doc: "Read in FA file with long lines and rewrite it with shorter lines.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: out_fa
    type: string
    doc: Output fasta file name
    inputBinding:
      position: 2
outputs:
  - id: output_fa
    type: File
    doc: Output fasta file with shorter lines
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chopfalines:482--h0b57e2e_0
