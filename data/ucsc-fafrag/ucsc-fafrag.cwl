cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFrag
label: ucsc-fafrag
doc: "Extract a piece of DNA from a .fa file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 10
  - id: start
    type: int
    doc: Start position of the piece to extract.
    inputBinding:
      position: 11
  - id: end
    type: int
    doc: End position of the piece to extract.
    inputBinding:
      position: 12
  - id: out_fa
    type: string
    doc: Output fasta file name
    inputBinding:
      position: 13
  - id: mixed
    type:
      - 'null'
      - boolean
    doc: Preserve mixed-case in FASTA file.
    inputBinding:
      position: 1
      prefix: -mixed
outputs:
  - id: output_fa
    type: File
    doc: Output fasta file with the extracted piece
    outputBinding:
      glob: $(inputs.out_fa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafrag:482--h0b57e2e_0
