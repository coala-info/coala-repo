cwlVersion: v1.2
class: CommandLineTool
baseCommand: nibFrag
label: ucsc-nibfrag
doc: "Extract sequence from a .nib file. The .nib file is a binary format used by
  UCSC to store DNA sequences, with 4 bits per base.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: nib_file
    type: File
    doc: The input .nib file.
    inputBinding:
      position: 1
  - id: start
    type: int
    doc: Start position in the nib file (0-based).
    inputBinding:
      position: 2
  - id: end
    type: int
    doc: End position in the nib file (non-inclusive).
    inputBinding:
      position: 3
  - id: strand
    type: string
    doc: "Strand: '+' or '-'."
    inputBinding:
      position: 4
  - id: hard_masked
    type:
      - 'null'
      - boolean
    doc: Use Ns for masked sequence.
    inputBinding:
      position: 105
      prefix: -hardMasked
  - id: masked
    type:
      - 'null'
      - boolean
    doc: Use lower case for masked sequence.
    inputBinding:
      position: 105
      prefix: -masked
  - id: upper
    type:
      - 'null'
      - boolean
    doc: Use upper case for all sequence.
    inputBinding:
      position: 105
      prefix: -upper
outputs:
  - id: output_fasta
    type: File
    doc: The output .fa file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nibfrag:482--h0b57e2e_0
