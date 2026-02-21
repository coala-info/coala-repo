cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdb_to_taxdump_acc2gtdb_tax.py
label: gtdb_to_taxdump_acc2gtdb_tax.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding container image building (no space left on device).\n
  \nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
stdout: gtdb_to_taxdump_acc2gtdb_tax.py.out
