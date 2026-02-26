cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - load
label: rgi_rgi load
doc: "Resistance Gene Identifier - 6.0.5 - Load\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: amr_kmers
    type:
      - 'null'
      - File
    doc: txt file of all amr kmers
    inputBinding:
      position: 101
      prefix: --amr_kmers
  - id: baits_annotation
    type:
      - 'null'
      - File
    doc: annotated reference FASTA
    inputBinding:
      position: 101
      prefix: --baits_annotation
  - id: baits_index
    type:
      - 'null'
      - File
    doc: baits index file (baits-probes-with-sequence-info.txt)
    inputBinding:
      position: 101
      prefix: --baits_index
  - id: card_annotation
    type:
      - 'null'
      - File
    doc: annotated reference FASTA for homolog models only, created using rgi 
      card_annotation
    inputBinding:
      position: 101
      prefix: --card_annotation
  - id: card_annotation_all_models
    type:
      - 'null'
      - File
    doc: annotated reference FASTA which includes all models created using rgi 
      card_annotation
    inputBinding:
      position: 101
      prefix: --card_annotation_all_models
  - id: card_json
    type: File
    doc: must be a card database json file
    inputBinding:
      position: 101
      prefix: --card_json
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: kmer_database
    type:
      - 'null'
      - File
    doc: json of kmer database
    inputBinding:
      position: 101
      prefix: --kmer_database
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size if loading kmer files
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'use local database (default: uses database in executable directory)'
    default: false
    inputBinding:
      position: 101
      prefix: --local
  - id: wildcard_annotation
    type:
      - 'null'
      - File
    doc: annotated reference FASTA for homolog models only, created using rgi 
      wildcard_annotation
    inputBinding:
      position: 101
      prefix: --wildcard_annotation
  - id: wildcard_annotation_all_models
    type:
      - 'null'
      - File
    doc: annotated reference FASTA which includes all models created using rgi 
      wildcard_annotation
    inputBinding:
      position: 101
      prefix: --wildcard_annotation_all_models
  - id: wildcard_index
    type:
      - 'null'
      - File
    doc: wildcard index file (index-for-model-sequences.txt)
    inputBinding:
      position: 101
      prefix: --wildcard_index
  - id: wildcard_version
    type:
      - 'null'
      - string
    doc: specify variants version used
    inputBinding:
      position: 101
      prefix: --wildcard_version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
stdout: rgi_rgi load.out
