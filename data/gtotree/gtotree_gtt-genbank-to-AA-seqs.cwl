cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-genbank-to-AA-seqs
label: gtotree_gtt-genbank-to-AA-seqs
doc: "Takes a genbank file and returns the amino acid sequences for all coding sequences.

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
    doc: "Output fasta file"
    default: clean.faa
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_faa
    type: File
    doc: "Amino acid fasta file"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
