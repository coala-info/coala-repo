cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_taxdump_gtdb_to_diamond.py
label: gtdb_to_taxdump_gtdb_to_diamond.py
doc: "A tool to convert GTDB (Genome Taxonomy Database) data to a DIAMOND-compatible
  taxdump format. (Note: The provided help text contains only system error messages
  and no usage information; arguments could not be extracted.)\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_gtdb_to_diamond.py.out
