cwlVersion: v1.2
class: CommandLineTool
baseCommand: tipp_TIPPo.v2.3.pl
label: tipp_TIPPo.v2.3.pl
doc: "Taxon Identification and Phylogenetic Profiling (TIPP) tool. Note: The provided
  text appears to be a container execution error log rather than help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/Wenfei-Xian/TIPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tipp:1.3.0--py38pl5321h077b44d_0
stdout: tipp_TIPPo.v2.3.pl.out
