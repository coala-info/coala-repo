cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur sequence-traits
label: augur_sequence-traits
doc: "Annotate sequences based on amino-acid or nucleotide signatures.\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: ancestral_sequences
    type:
      - 'null'
      - File
    doc: nucleotide alignment (VCF) to search for sequence traits in (can be 
      generated from 'ancestral' using '--output-vcf')
    inputBinding:
      position: 101
      prefix: --ancestral-sequences
  - id: count
    type:
      - 'null'
      - string
    doc: 'Whether to count traits (ex: # drugs resistant to) or mutations'
    inputBinding:
      position: 101
      prefix: --count
  - id: features
    type:
      - 'null'
      - File
    doc: 'file that specifies sites defining the features in a tab-delimited format:
      "GENE SITE ALT DISPLAY_NAME FEATURE". For nucleotide sites, GENE can be "nuc"
      (or column excluded entirely for all-nuc sites). "DISPLAY_NAME" can be blank
      or excluded entirely.'
    inputBinding:
      position: 101
      prefix: --features
  - id: label
    type:
      - 'null'
      - string
    doc: 'How to label the counts (ex: Drug_Resistance)'
    inputBinding:
      position: 101
      prefix: --label
  - id: translations
    type:
      - 'null'
      - File
    doc: AA alignment to search for sequence traits in (can include ancestral 
      sequences)
    inputBinding:
      position: 101
      prefix: --translations
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: fasta file of the sequence the nucleotide VCF was mapped to
    inputBinding:
      position: 101
      prefix: --vcf-reference
  - id: vcf_translate_reference
    type:
      - 'null'
      - File
    doc: fasta file of the sequence the translated VCF was mapped to
    inputBinding:
      position: 101
      prefix: --vcf-translate-reference
outputs:
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: name of JSON file to save sequence features to
    outputBinding:
      glob: $(inputs.output_node_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
