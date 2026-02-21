cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaeger
label: jaeger-bio
doc: "Jaeger is a deep learning-based tool for identifying prophages in genomic sequences.\n
  \nTool homepage: https://github.com/Yasas1994/Jaeger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaeger-bio:1.1.30--pyhdfd78af_0
stdout: jaeger-bio.out
