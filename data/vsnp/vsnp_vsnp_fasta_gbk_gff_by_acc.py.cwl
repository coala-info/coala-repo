cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_fasta_gbk_gff_by_acc.py
label: vsnp_vsnp_fasta_gbk_gff_by_acc.py
doc: "Download a FASTA, GenBank or GFF file for a complete NCBI chromosome accession (needs\
  \ network access).\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: NCBI chromosome number
    inputBinding:
      position: 101
      prefix: -a
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: get FASTA file
    inputBinding:
      position: 101
      prefix: -f
  - id: gbk
    type:
      - 'null'
      - boolean
    doc: get gbk file
    inputBinding:
      position: 101
      prefix: -b
  - id: gff
    type:
      - 'null'
      - boolean
    doc: get gff file
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fasta_file
    type:
      type: array
      items: File
    doc: Downloaded FASTA, GenBank and GFF files
    outputBinding:
      glob: $(inputs.accession).*
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_fasta_gbk_gff_by_acc.py.out
