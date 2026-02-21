cwlVersion: v1.2
class: CommandLineTool
baseCommand: goslimmer
label: goslimmer
doc: "A tool for GO (Gene Ontology) slimming, though the provided text contains only
  container runtime error logs and no usage information.\n\nTool homepage: https://github.com/DanFaria/GOSlimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goslimmer:1.0--0
stdout: goslimmer.out
