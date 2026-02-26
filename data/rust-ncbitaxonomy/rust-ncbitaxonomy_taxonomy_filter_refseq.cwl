cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_filter_refseq
label: rust-ncbitaxonomy_taxonomy_filter_refseq
doc: "Filter NCBI RefSeq FASTA files by taxonomic lineage\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
inputs:
  - id: input_fasta
    type: File
    doc: FASTA file with RefSeq sequences
    inputBinding:
      position: 1
  - id: ancestor_name
    type: string
    doc: Name of ancestor to use as ancestor filter
    inputBinding:
      position: 2
  - id: db
    type:
      - 'null'
      - string
    doc: URL for SQLite taxonomy database
    inputBinding:
      position: 103
      prefix: --db
  - id: no_curated
    type:
      - 'null'
      - boolean
    doc: Don't accept curated RNAs and proteins (NM_, NR_ and NP_ accessions)
    inputBinding:
      position: 103
      prefix: --no_curated
  - id: no_predicted
    type:
      - 'null'
      - boolean
    doc: Don't accept computationally predicted RNAs and proteins (XM_, XR_ and 
      XP_ accessions)
    inputBinding:
      position: 103
      prefix: --no_predicted
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA filename (or stdout if omitted)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
