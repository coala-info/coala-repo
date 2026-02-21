cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaseq
label: metaseq
doc: "A framework for integrative analysis of high-throughput sequencing data.\n\n
  Tool homepage: https://github.com/facebookresearch/metaseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaseq:0.5.6--py27_2
stdout: metaseq.out
