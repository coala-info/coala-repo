cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_taxdump_gtdb_to_taxdump.py
label: gtdb_to_taxdump_gtdb_to_taxdump.py
doc: "A tool to convert GTDB (Genome Taxonomy Database) taxonomy data into NCBI-style
  taxdump format.\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_gtdb_to_taxdump.py.out
