cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocaller
label: nanocaller
doc: "NanoCaller is a computational tool for somatic and germline variant calling
  (SNPs and indels) from Oxford Nanopore and PacBio long-read sequencing data.\n\n
  Tool homepage: https://github.com/WGLab/NanoCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocaller:3.6.2--h42286b9_0
stdout: nanocaller.out
