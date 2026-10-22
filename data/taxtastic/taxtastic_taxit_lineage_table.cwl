cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - lineage_table
label: taxtastic_taxit_lineage_table
doc: "Create a table of lineages as taxonomic names for a collection of sequences\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: seqname_col
    type:
      - 'null'
      - string
    doc: 'Name of column in seq_info containing sequence names'
    inputBinding:
      position: 1
      prefix: --seqname-col
  - id: tax_id_col
    type:
      - 'null'
      - string
    doc: 'Name of column in seq_info containing tax_ids'
    inputBinding:
      position: 1
      prefix: --tax-id-col
  - id: csv_table
    type:
      - 'null'
      - string
    doc: 'Output file containing lineages for each sequence name in csv format'
    inputBinding:
      position: 1
      prefix: --csv-table
  - id: taxonomy_table
    type:
      - 'null'
      - string
    doc: 'Taxonomy file formatted for MOTHUR'
    inputBinding:
      position: 1
      prefix: --taxonomy-table
  - id: taxtable
    type: File
    doc: 'Output of taxit taxtable containing all tax_ids represented in seq_info'
    inputBinding:
      position: 101
  - id: seq_info
    type: File
    doc: 'Csv file providing a mapping of sequence names to tax_ids'
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: csv_table_file
    type:
      - 'null'
      - File
    doc: 'Lineages for each sequence in csv format'
    outputBinding:
      glob: $(inputs.csv_table)
  - id: taxonomy_table_file
    type:
      - 'null'
      - File
    doc: 'Taxonomy file formatted for MOTHUR'
    outputBinding:
      glob: $(inputs.taxonomy_table)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_lineage_table.out
