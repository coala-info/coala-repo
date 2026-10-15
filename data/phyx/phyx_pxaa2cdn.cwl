cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxaa2cdn]
label: phyx_pxaa2cdn
doc: |-
  Generate a codon alignment from aligned amino acids and unaligned nucleotides.
  Taxa found in only 1 input file will be removed.
  This will take fasta, fastq, phylip, and nexus inputs.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: aa_seq_file
    type: File
    doc: "input amino acid sequence file (aligned)"
    inputBinding:
      prefix: -a
  - id: nuc_seq_file
    type: File
    doc: "input nucleotide sequence file (unaligned)"
    inputBinding:
      prefix: -n
  - id: out_file_path
    type: string
    doc: "output fasta file name"
    inputBinding:
      prefix: -o
  - id: rmlastcdn
    type: ['null', boolean]
    doc: "removes last codon (default: false)"
    inputBinding:
      prefix: -r
outputs:
  - id: out_file
    type: File
    doc: "output codon alignment (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
