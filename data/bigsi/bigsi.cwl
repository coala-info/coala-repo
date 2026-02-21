cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi
label: bigsi
doc: "BIGSI: a scalable search index for genomic data. Note: The provided help text
  contains system error logs and does not list specific command-line arguments.\n\n
  Tool homepage: https://github.com/Phelimb/BIGSI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi.out
