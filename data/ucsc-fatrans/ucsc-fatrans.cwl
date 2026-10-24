cwlVersion: v1.2
class: CommandLineTool
baseCommand: faTrans
label: ucsc-fatrans
doc: "Translate DNA .fa file to peptide.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input DNA FASTA file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output peptide FASTA file
    inputBinding:
      position: 2
  - id: stop
    type:
      - 'null'
      - boolean
    doc: Stop at first stop codon (otherwise puts in Z for stop codons)
    inputBinding:
      position: 101
      prefix: -stop
  - id: offset
    type:
      - 'null'
      - int
    doc: Start at a particular offset
    inputBinding:
      position: 101
      prefix: -offset=
      separate: false
  - id: cds_upper
    type:
      - 'null'
      - boolean
    doc: CDS is in upper case
    inputBinding:
      position: 101
      prefix: -cdsUpper
outputs:
  - id: output_fasta
    type: File
    doc: Output peptide FASTA file
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatrans:482--h0b57e2e_0
