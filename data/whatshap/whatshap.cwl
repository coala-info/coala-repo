cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatshap
label: whatshap
doc: "Phasing genomic variants using DNA sequencing reads\n\nTool homepage: https://whatshap.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
stdout: whatshap.out
