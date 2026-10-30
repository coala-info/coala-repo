cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_download_GCA_fasta_get_metadata.py
label: vsnp3_vsnp3_download_GCA_fasta_get_metadata.py
doc: "Use NCBI's datasets tool to download GCF and GCA genomes and their metadata (needs network\
  \ access).\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: accession
    type: string
    doc: NCBI chromosome number -- GCA NUMBER, FASTA downloaded
    inputBinding:
      position: 101
      prefix: -a
  - id: gfiles
    type:
      - 'null'
      - boolean
    doc: download gff3 and gbk files
    inputBinding:
      position: 101
      prefix: -g
  - id: rename
    type:
      - 'null'
      - boolean
    doc: rename file with metadata
    inputBinding:
      position: 101
      prefix: -r
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep temp file
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: downloads
    type:
      type: array
      items: File
    doc: Downloaded genome, annotation and metadata files
    outputBinding:
      glob:
        - '*.fasta'
        - '*.fna'
        - '*.gbk'
        - '*.gff3'
        - '*.gff'
        - '*.xlsx'
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_download_GCA_fasta_get_metadata.py.stdout.txt
