cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansnper
label: cansnper
doc: "A tool for SNP-based genotyping and phylogenetic analysis (Note: The provided
  text contains system error logs rather than help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://github.com/adrlar/CanSNPer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper:1.0.10--py_1
stdout: cansnper.out
