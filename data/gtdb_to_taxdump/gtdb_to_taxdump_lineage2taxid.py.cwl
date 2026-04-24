cwlVersion: v1.2
class: CommandLineTool
baseCommand: lineage2taxid.py
label: gtdb_to_taxdump_lineage2taxid.py
doc: "Map taxonomic lineages to taxids\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs:
  - id: table_file
    type: File
    doc: Tab-delim input table containing GTDB taxonomic lineages
    inputBinding:
      position: 1
  - id: names_dmp
    type: File
    doc: NCBI names.dmp file. Only needed if providing NCBI taxids
    inputBinding:
      position: 2
  - id: nodes_dmp
    type: File
    doc: NCBI nodes.dmp file. Only needed if providing NCBI taxids
    inputBinding:
      position: 3
  - id: lineage_column
    type:
      - 'null'
      - string
    doc: Column name that contains the lineages
    inputBinding:
      position: 104
      prefix: --lineage-column
  - id: taxid_column
    type:
      - 'null'
      - string
    doc: Name of taxid column that will be appended to the input table
    inputBinding:
      position: 104
      prefix: --taxid-column
  - id: taxid_rank_column
    type:
      - 'null'
      - string
    doc: Name of taxid-rank column that will be appended to the input table
    inputBinding:
      position: 104
      prefix: --taxid-rank-column
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_lineage2taxid.py.out
