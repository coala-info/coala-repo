cwlVersion: v1.2
class: CommandLineTool
baseCommand: retroseq
label: perl-retroseq
doc: "RetroSeq is a tool for detecting non-reference Transposable Element (TE) insertions
  from next-generation sequencing alignment data. Note: The provided help text contains
  only system error messages regarding a container build failure and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/tk2/RetroSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
stdout: perl-retroseq.out
