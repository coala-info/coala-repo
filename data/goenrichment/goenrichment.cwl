cwlVersion: v1.2
class: CommandLineTool
baseCommand: goenrichment
label: goenrichment
doc: "A tool for Gene Ontology (GO) enrichment analysis.\n\nTool homepage: https://github.com/DanFaria/GOEnrichment"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goenrichment:2.0.1--0
stdout: goenrichment.out
