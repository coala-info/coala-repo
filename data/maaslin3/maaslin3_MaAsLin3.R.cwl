cwlVersion: v1.2
class: CommandLineTool
baseCommand: MaAsLin3.R
label: maaslin3_MaAsLin3.R
doc: "MaAsLin3 (Multivariable Association with Linear Models) is a tool for finding
  associations between phenotypes and microbial community features.\n\nTool homepage:
  https://github.com/biobakery/maaslin3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin3:0.99.16--r44hdfd78af_1
stdout: maaslin3_MaAsLin3.R.out
