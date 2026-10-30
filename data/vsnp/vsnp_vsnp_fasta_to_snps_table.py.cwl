cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_fasta_to_snps_table.py
label: vsnp_vsnp_fasta_to_snps_table.py
doc: "Build a parsimonious SNP table and RAxML tree from an aligned FASTA. One FASTA header\
  \ must be named \"reference_seq\" (the root).\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: fasta
    type: File
    doc: provide an aligned fasta
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: parsimonious_alignment
    type:
      type: array
      items: File
    doc: Parsimonious alignment (FASTA and JSON)
    outputBinding:
      glob:
        - '*_parsimonious_alignment-*.fasta'
        - '*_parsimonious_alignment-*.json'
  - id: tree
    type:
      type: array
      items: File
    doc: Tree file, or a message when too few samples
    outputBinding:
      glob:
        - '*.tre'
        - TOO_FEW_SAMPLES_TO_BUILD_TREE
        - SEE_RAXML_INFO
  - id: tables
    type:
      type: array
      items: File
    doc: SNP tables
    outputBinding:
      glob:
        - '*.xlsx'
        - '*.csv'
        - idtable.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_fasta_to_snps_table.py.out
