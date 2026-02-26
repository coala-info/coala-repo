cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk del_finder
label: datafunk_del_finder
doc: "Query an alignment position for deletions\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: append_as_snp
    type:
      - 'null'
      - boolean
    doc: "If invoked, then append the genotype of the deletion\n                 \
      \       as a SNP on the end of the alignment"
    inputBinding:
      position: 101
      prefix: --append-as-SNP
  - id: deletions_file
    type: File
    doc: "Input CSV file with deletions type. Format is: 1-based\n               \
      \         start position of deletion,length of deletion (dont\n            \
      \            include a header line), eg: 1605,3"
    inputBinding:
      position: 101
      prefix: --deletions-file
  - id: input_fasta
    type: File
    doc: Alignment (to Wuhan-Hu-1) in Fasta format to type
    inputBinding:
      position: 101
      prefix: --input-fasta
outputs:
  - id: genotypes_table
    type: File
    doc: "CSV file with deletion typing results to write.\n                      \
      \  Returns the genotype for each deletion in --deletions-\n                \
      \        file for each sequence in --input-fasta: either \"ref\",\n        \
      \                \"del\" or \"X\" (for missing data)"
    outputBinding:
      glob: $(inputs.genotypes_table)
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Fasta file to write
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
