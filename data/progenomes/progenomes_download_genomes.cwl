cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - progenomes
  - download
  - genomes
label: progenomes_download_genomes
doc: "Download the representative genome set from the Progenomes database into the working directory.\n\nTool homepage: https://github.com/BigDataBiology/progenomes-cli"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: genome_set
    type: string
    doc: "Representative genome set to download (representative-genomes)."
    inputBinding:
      position: 2
  - id: contigs
    type:
      - 'null'
      - boolean
    doc: "Contigs"
    inputBinding:
      position: 1
      prefix: --contigs
  - id: genes
    type:
      - 'null'
      - boolean
    doc: "Genes"
    inputBinding:
      position: 1
      prefix: --genes
  - id: proteins
    type:
      - 'null'
      - boolean
    doc: "Proteins"
    inputBinding:
      position: 1
      prefix: --proteins
  - id: all
    type:
      - 'null'
      - boolean
    doc: "All"
    inputBinding:
      position: 1
      prefix: --all
outputs:
  - id: downloaded_files
    type:
      type: array
      items: File
    doc: Downloaded genome files
    outputBinding:
      glob: ['*.gz','*.tar','*.fna','*.faa','*.tsv','*.parquet']
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
stdout: progenomes_download_genomes.out
