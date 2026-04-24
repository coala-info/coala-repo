cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher database
label: philosopher_database
doc: "Process a database for peptide identification.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: add_contaminants
    type:
      - 'null'
      - boolean
    doc: add common contaminants
    inputBinding:
      position: 101
      prefix: --contam
  - id: add_custom_sequences
    type:
      - 'null'
      - string
    doc: add custom sequences (UniProt FASTA format only)
    inputBinding:
      position: 101
      prefix: --add
  - id: add_isoforms
    type:
      - 'null'
      - boolean
    doc: add isoform sequences
    inputBinding:
      position: 101
      prefix: --isoform
  - id: annotate
    type:
      - 'null'
      - string
    doc: process a ready-to-use database
    inputBinding:
      position: 101
      prefix: --annotate
  - id: contaminant_prefix
    type:
      - 'null'
      - boolean
    doc: mark the contaminant sequences with a prefix tag
    inputBinding:
      position: 101
      prefix: --contamprefix
  - id: custom_database
    type:
      - 'null'
      - string
    doc: use a pre-formatted custom database
    inputBinding:
      position: 101
      prefix: --custom
  - id: debug_sequence_classification
    type:
      - 'null'
      - boolean
    doc: debug the sequence classification for each FASTA record
    inputBinding:
      position: 101
      prefix: --verbose
  - id: decoy_mode
    type:
      - 'null'
      - int
    doc: 'define the decoy generating mode, 0: revere sequence (default), 1:reverse
      and shift KR, 2:reverse and swap Kr'
    inputBinding:
      position: 101
      prefix: --decoymode
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: define a decoy prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: enzyme
    type:
      - 'null'
      - string
    doc: enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin)
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: no_decoys
    type:
      - 'null'
      - boolean
    doc: don't add decoys to the database
    inputBinding:
      position: 101
      prefix: --nodecoys
  - id: reviewed_sequences
    type:
      - 'null'
      - boolean
    doc: use only reviwed sequences from Swiss-Prot
    inputBinding:
      position: 101
      prefix: --reviewed
  - id: uniprot_id
    type:
      - 'null'
      - string
    doc: UniProt proteome ID
    inputBinding:
      position: 101
      prefix: --id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_database.out
