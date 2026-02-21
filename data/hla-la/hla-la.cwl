cwlVersion: v1.2
class: CommandLineTool
baseCommand: HLA-LA
label: hla-la
doc: "HLA-LA (HLA-Locus Assembly) is a tool for HLA typing from NGS data. Note: The
  provided text appears to be a container runtime error log (out of disk space) rather
  than the tool's help documentation, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/DiltheyLab/HLA-LA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-la:1.0.4--h077b44d_1
stdout: hla-la.out
