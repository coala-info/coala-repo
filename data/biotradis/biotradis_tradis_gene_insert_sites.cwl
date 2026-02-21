cwlVersion: v1.2
class: CommandLineTool
baseCommand: tradis_gene_insert_sites
label: biotradis_tradis_gene_insert_sites
doc: "A tool for analyzing TraDIS gene insertion sites. Note: The provided help text
  contains execution errors and does not list specific arguments.\n\nTool homepage:
  https://github.com/sanger-pathogens/Bio-Tradis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
stdout: biotradis_tradis_gene_insert_sites.out
