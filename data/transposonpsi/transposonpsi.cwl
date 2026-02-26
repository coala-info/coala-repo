cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposonPSI.pl
label: transposonpsi
doc: "TransposonPSI is used to identify transposon-derived ORFs in DNA or protein
  sequences by searching against a database of transposon-specific profiles.\n\nTool
  homepage: http://transposonpsi.sourceforge.net/"
inputs:
  - id: fasta_file
    type: File
    doc: Target FASTA file to search (DNA or protein)
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: "Type of sequence: 'nuc' for nucleotide or 'prot' for protein"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposonpsi:1.0.0--hdfd78af_3
stdout: transposonpsi.out
