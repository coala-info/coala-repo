cwlVersion: v1.2
class: CommandLineTool
baseCommand: keggcharter
label: keggcharter
doc: "A tool for representation of metabolic potential and gene expression on KEGG
  metabolic maps. (Note: The provided text contains only system error messages and
  no help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/iquasere/KEGGCharter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/keggcharter:1.1.2--hdfd78af_0
stdout: keggcharter.out
