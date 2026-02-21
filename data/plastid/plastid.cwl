cwlVersion: v1.2
class: CommandLineTool
baseCommand: plastid
label: plastid
doc: "A Python library for genomic analysis, specifically designed for high-throughput
  sequencing data like Ribo-seq and RNA-seq.\n\nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid.out
