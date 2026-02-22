cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobox_add_taxid
label: biobox_add_taxid
doc: "A tool to add taxonomic identifiers (TaxIDs) to biobox profiling files.\n\n\
  Tool homepage: https://github.com/SantaMcCloud/biobox_add_taxid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobox_add_taxid:1.2--pyh7e72e81_0
stdout: biobox_add_taxid.out
