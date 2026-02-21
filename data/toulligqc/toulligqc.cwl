cwlVersion: v1.2
class: CommandLineTool
baseCommand: toulligqc
label: toulligqc
doc: "A post sequencing QC tool for Oxford Nanopore sequencing data (Note: The provided
  help text contains only container runtime logs and a fatal error, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/GenomicParisCentre/toulligQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toulligqc:2.8--pyhdfd78af_0
stdout: toulligqc.out
