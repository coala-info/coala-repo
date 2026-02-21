cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_taxdump_ncbi-gtdb_map.py
label: gtdb_to_taxdump_ncbi-gtdb_map.py
doc: "A tool to map NCBI and GTDB taxonomies. (Note: The provided help text contains
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_ncbi-gtdb_map.py.out
