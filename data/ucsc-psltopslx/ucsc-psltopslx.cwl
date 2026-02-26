cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToPslx
label: ucsc-psltopslx
doc: "Convert PSL format (alignment without sequence) to PSLX format (alignment with
  sequence) by fetching sequences from FASTA files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: q_sequence
    type: File
    doc: Query sequence in FASTA format.
    inputBinding:
      position: 2
  - id: t_sequence
    type: File
    doc: Target sequence in FASTA format.
    inputBinding:
      position: 3
  - id: masked
    type:
      - 'null'
      - boolean
    doc: Use masked sequence from FASTA files.
    inputBinding:
      position: 104
      prefix: -masked
outputs:
  - id: out_pslx
    type: File
    doc: Output PSLX file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltopslx:482--h0b57e2e_0
