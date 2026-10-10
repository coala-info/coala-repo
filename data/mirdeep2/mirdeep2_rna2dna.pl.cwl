cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rna2dna.pl
label: mirdeep2_rna2dna.pl
doc: "Convert RNA sequences in a fasta file to DNA by substituting 'U' with 'T' (ids are cut at the first whitespace, sequences are printed in upper case)\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_fasta
    type: File
    doc: Fasta file with RNA sequences
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Fasta file with DNA sequences
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: dna.fa
