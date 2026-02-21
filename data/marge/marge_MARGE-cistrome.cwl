cwlVersion: v1.2
class: CommandLineTool
baseCommand: marge
label: marge_MARGE-cistrome
doc: "MARGE (Model-based Analysis of Regulation of Gene Expression) is a framework
  for interpreting cis-regulation of gene expression.\n\nTool homepage: http://cistrome.org/MARGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marge:1.0--py35h24bf2e0_1
stdout: marge_MARGE-cistrome.out
