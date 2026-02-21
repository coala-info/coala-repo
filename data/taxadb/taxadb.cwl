cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxadb
label: taxadb
doc: "A tool for creating and querying local taxonomic databases.\n\nTool homepage:
  https://github.com/HadrienG/taxadb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
stdout: taxadb.out
