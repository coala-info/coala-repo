cwlVersion: v1.2
class: CommandLineTool
baseCommand: negspy
label: negspy
doc: "A python package for handling genomic coordinates and chromosome sizes.\n\n
  Tool homepage: https://github.com/pkerpedjiev/negspy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
stdout: negspy.out
