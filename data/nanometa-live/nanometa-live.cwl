cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanometa-live
label: nanometa-live
doc: "A tool for real-time taxonomic analysis of Nanopore metagenomic data (Note:
  Provided help text contained only system error logs and no usage information).\n
  \nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live.out
