cwlVersion: v1.2
class: CommandLineTool
baseCommand: HLA-LA.pl
label: hla-la_HLA-LA.pl
doc: "HLA-LA is a tool for HLA typing from NGS data. (Note: The provided text contains
  only system error logs regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/DiltheyLab/HLA-LA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-la:1.0.4--h077b44d_1
stdout: hla-la_HLA-LA.pl.out
