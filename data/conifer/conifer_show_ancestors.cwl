cwlVersion: v1.2
class: CommandLineTool
baseCommand: show_ancestors
label: conifer_show_ancestors
doc: "Print the lineage of a taxid (rank, taxid and name of the taxon and each ancestor
  up to the root) from a Kraken2 taxonomy (taxo.k2d).\n\nTool homepage: https://github.com/Ivarz/Conifer/"
inputs:
  - id: taxid
    type: string
    doc: taxid whose ancestors are printed
    inputBinding:
      position: 101
      prefix: --taxid
  - id: db
    type: File
    doc: Kraken2 taxonomy file (taxo.k2d)
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: 'tab-separated lineage: rank, taxid, name'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
stdout: conifer_show_ancestors.out
