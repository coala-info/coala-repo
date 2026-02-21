cwlVersion: v1.2
class: CommandLineTool
baseCommand: maaslin
label: maaslin
doc: "MaAsLin (Multivariate Analysis by Linear Models) is a tool for determining associations
  between clinical metadata and microbial community abundance.\n\nTool homepage: https://huttenhower.sph.harvard.edu/maaslin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin:0.05--r351_0
stdout: maaslin.out
