cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcscanx_detect_collinearity_within_gene_families.pl
label: mcscanx_detect_collinearity_within_gene_families.pl
doc: "A script within the MCScanX toolkit for detecting collinearity within gene families.\n
  \nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_detect_collinearity_within_gene_families.pl.out
