cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-genbank-to-fasta
label: gtotree_gtt-genbank-to-fasta
doc: "Takes a genbank file and outputs a flat fasta file of all nucleotides.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_gb
    type: File
    doc: "input Genbank file (e.g. \"*.gbk\", \"*.gb\", \"*.gbff\")"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Output fasta file with matching, simplified headers"
    default: clean.fa
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_fa
    type: File
    doc: "Nucleotide fasta file"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
