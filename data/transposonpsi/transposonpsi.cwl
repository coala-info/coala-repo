cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposonPSI.pl
label: transposonpsi
doc: "TransposonPSI performs analyses to identify transposon-related sequences in a nucleotide or protein FASTA file, using PSI-BLAST profiles of transposon protein families. Results are written next to the input name as FASTA-NAME.TPSI.* files.\n\nTool homepage: https://github.com/NBISweden/TransposonPSI"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file with the sequences to search
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: "Type of the sequences in the FASTA file: prot (protein) or nuc (nucleotide)"
    inputBinding:
      position: 2
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: TransposonPSI result files (allHits, topHits for protein input; chains, GFF3 and best-per-locus files for nucleotide input)
    outputBinding:
      glob: $(inputs.fasta_file.basename).TPSI.*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposonpsi:1.0.0--hdfd78af_3
