cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxid_name
label: conifer_taxid_name
doc: "Print the scientific name of a taxid from a Kraken2 taxonomy (taxo.k2d).\n\nTool
  homepage: https://github.com/Ivarz/Conifer/"
inputs:
  - id: taxid
    type: string
    doc: taxid to look up
    inputBinding:
      position: 1
  - id: db
    type: File
    doc: Kraken2 taxonomy file (taxo.k2d)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: name of the taxon
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
stdout: conifer_taxid_name.out
