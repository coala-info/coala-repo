cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiimetomaaslin
label: qiimetomaaslin
doc: "A tool for converting QIIME output data into a format compatible with MaAsLin.\n
  \nTool homepage: https://github.com/biobakery/qiimetomaaslin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qiimetomaaslin:1.1.0--py27_0
stdout: qiimetomaaslin.out
