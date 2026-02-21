cwlVersion: v1.2
class: CommandLineTool
baseCommand: maaslin3
label: maaslin3
doc: "MaAsLin3 (Microbiome Multivariable Association with Linear Models) is a tool
  for determining associations between clinical metadata and microbial community measurements.\n
  \nTool homepage: https://github.com/biobakery/maaslin3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin3:0.99.16--r44hdfd78af_1
stdout: maaslin3.out
