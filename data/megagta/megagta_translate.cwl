cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - translate
label: megagta_translate
doc: "Translate the DNA sequences of a FASTA file to protein; the protein FASTA
  goes to standard output.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: nucl_seq
    type: File
    doc: Nucleotide sequences in FASTA format
    inputBinding:
      position: 1
outputs:
  - id: protein_seq
    type: stdout
    doc: Translated protein sequences in FASTA format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_translate.faa
