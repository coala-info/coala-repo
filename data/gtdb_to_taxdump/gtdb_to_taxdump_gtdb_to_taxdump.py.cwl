cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_taxdump.py
label: gtdb_to_taxdump_gtdb_to_taxdump.py
doc: "Convert Genome Taxonomy Database (GTDB) taxonomy files to NCBI taxdump format
  (names.dmp & nodes.dmp).\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs:
  - id: tax_files
    type:
      type: array
      items: File
    doc: '>=1 taxonomy file (or url)'
    inputBinding:
      position: 1
  - id: column
    type:
      - 'null'
      - string
    doc: Column in --table that contains genome accessions
    inputBinding:
      position: 102
      prefix: --column
  - id: embl_code
    type:
      - 'null'
      - string
    doc: embl code to use for all nodes
    inputBinding:
      position: 102
      prefix: --embl-code
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: table
    type:
      - 'null'
      - File
    doc: Table to append taxIDs to. Accessions used for table join
    inputBinding:
      position: 102
      prefix: --table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_gtdb_to_taxdump.py.out
